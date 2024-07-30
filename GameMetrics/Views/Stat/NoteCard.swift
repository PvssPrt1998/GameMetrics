//
//  NoteCard.swift
//  GameMetrics
//
//  Created by Николай Щербаков on 30.07.2024.
//

import SwiftUI

struct NoteCard: View {
    
    let note: Note
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                TextCustom(text: note.name, size: 17, weight: .semibold, color: .specialPrimary)
                TextCustom(text: note.description, size: 15, weight: .regular, color: .textMain)
            }
            Spacer()
            TextCustom(text: "#\(note.tag)", size: 15, weight: .regular, color: .pink)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.onboardingControls, lineWidth: 2)
                )
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

#Preview {
    NoteCard(note: Note(name: "name", description: "description", tag: "tag", color: [50,50,50,1]))
        .background(Color.white)
}
