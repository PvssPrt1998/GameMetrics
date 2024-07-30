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
            TextCustom(text: "#\(note.tag)", size: 15, weight: .regular, color: noteColor())
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(noteColor(), lineWidth: 2)
                )
        }
        .padding(EdgeInsets(top: 10, leading: horizontalPadding(), bottom: 10, trailing: horizontalPadding()))
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 50 : 16
    }
    
    private func noteColor() -> Color {
        Color(red: note.color[0], green: note.color[1], blue: note.color[2], opacity: note.color[3])
    }
}

#Preview {
    NoteCard(note: Note(isDotaType: true, name: "name", description: "description", tag: "tag", color: [50,50,50,1]))
        .background(Color.white)
}
