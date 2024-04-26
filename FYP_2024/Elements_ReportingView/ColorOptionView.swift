import SwiftUI

struct ColorOption: Identifiable {
    let id = UUID()
    let color: Color
    let description: String
}

struct ColorOptions {
    static let options: [ColorOption] = [
        ColorOption(color: .red, description: "Red"),
        ColorOption(color: .green, description: "Green"),
        ColorOption(color: .blue, description: "Blue"),
        ColorOption(color: .yellow, description: "Yellow"),
        ColorOption(color: .orange, description: "Orange"),
        ColorOption(color: .purple, description: "Purple"),
        ColorOption(color: .pink, description: "Pink"),
        ColorOption(color: .brown, description: "Brown"),
        ColorOption(color: .gray, description: "Gray"),
        ColorOption(color: .black, description: "Black")
    ]
}


struct ColorOptionView: View {
    let colorOption: ColorOption
    @Binding var selectedColors: [Color]

    var body: some View {
        Button(action: {
            if selectedColors.contains(colorOption.color) {
                selectedColors.removeAll(where: { $0 == colorOption.color })
            } else {
                selectedColors.append(colorOption.color)
            }
        }) {
            VStack {
                Circle()
                    .fill(colorOption.color)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(selectedColors.contains(colorOption.color) ? Color.white : Color.clear, lineWidth: 2)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: selectedColors.contains(colorOption.color) ? "checkmark" : "")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            )
                    )
                Text(colorOption.description)
                    .font(.caption)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}



#Preview {
    ColorOptionView(colorOption: ColorOption(color: .red, description: "Red"),
                    selectedColors: .constant([
                                        ColorOption(color: .red, description: "Red").color
                                    ])
    )
}
