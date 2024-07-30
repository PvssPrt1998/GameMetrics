//
//  EditTextField.swift
//  GameMetrics
//
//  Created by Николай Щербаков on 29.07.2024.
//

import SwiftUI

struct EditTextField: View {
    
    @Binding var text: String
    
    let label: String
    let placeholder: String
    var trailingPadding: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 10) {
            TextCustom(text: label, size: 17, weight: .semibold, color: Color.textFieldText)
            TextField("", text: $text)
                .fontCustom(size: 15, weight: .regular, color: Color.textFieldText)
                .autocorrectionDisabled(true)
                .background(
                    placeholderView()
                )
        }
        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 0))
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.onboardingControls, lineWidth: 2)
        )
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .fontCustom(size: 15, weight: .regular, color: Color.placeholder)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct EditTextField_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        EditTextField(text: $text, label: "Name", placeholder: "Enter")
    }
}
