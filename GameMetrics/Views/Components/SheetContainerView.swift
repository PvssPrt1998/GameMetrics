//
//  SheetContainerView.swift
//  GameMetrics
//
//  Created by Николай Щербаков on 30.07.2024.
//

import SwiftUI

struct SheetContainerView<Content: View>: View {
    
    @StateObject var sheetSizeManager: SheetSizeManager
    @Binding var showSheet: Bool
    @ViewBuilder let content: Content
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.white)
            .cornerRadius(10, corners: [.topLeft, .topRight])
            .offset(x: 0, y: sheetSizeManager.topPadding)
            .gesture(
                sheetSizeManager.dragGesture
                    .onChanged({value in
                        sheetSizeManager.dragGestureOnChanged(value)
                    })
                    .onEnded({ value in
                        if sheetSizeManager.dragGestureOnEnded(value) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                showSheet = false
                            }
                        }
                    })
            )
            .onAppear {
                sheetSizeManager.appearance()
            }
    }
}

class SheetSizeManager: ObservableObject {
    
    let defaultPadding: CGFloat = 386
    @Published var topPadding: CGFloat
    
    let screenHeight: CGFloat
    let sheetHeight: CGFloat
    
    let dragGesture: DragGesture
    
    init(screenHeight: CGFloat) {
        self.dragGesture = DragGesture()
        self.screenHeight = screenHeight
        self.sheetHeight = screenHeight - defaultPadding
        self.topPadding = screenHeight
    }
    
    func appearance() {
        withAnimation(.linear(duration: 0.2)) {
            topPadding = defaultPadding
        }
    }
    
    func dragGestureOnChanged(_ value: DragGesture.Value) {
        if value.translation.height > 0 { //drag to bottom
            topPadding = defaultPadding + value.translation.height
        }
    }
    
    func dragGestureOnEnded(_ value: DragGesture.Value) -> Bool {
        let velocity = CGSize(
            width:  value.predictedEndLocation.x - value.location.x,
            height: value.predictedEndLocation.y - value.location.y
        )
        if value.translation.height + velocity.height > (sheetHeight / 2) {
            withAnimation(.linear(duration: 0.1)) {
                topPadding = screenHeight
            }
            return true
        }
        if value.translation.height + velocity.height < (sheetHeight / 2) {
            withAnimation {
                topPadding = defaultPadding
            }
        }
        return false
    }
}

