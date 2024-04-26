import SwiftUI

struct ColorSampleView: View {
    let color: Color
    @Binding var selectedColor: Color

    var body: some View {
        Button(action: {
            selectedColor = color
        }) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)

                if selectedColor == color {
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 44, height: 44)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 4)
        .accessibilityLabel(color.description)
    }
}


#Preview {
    ColorSampleView(color: .blue, selectedColor: .constant(.red))
}

