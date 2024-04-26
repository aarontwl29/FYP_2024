import SwiftUI

struct RadioButtonField<T: Hashable>: View {
    let id: T
    let label: String
    @Binding var selectedValue: T?
    
    var body: some View {
        Button(action: {
            selectedValue = selectedValue == id ? nil : id
        }) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .stroke(selectedValue == id ? Color.accentColor : Color.gray, lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if selectedValue == id {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 12, height: 12)
                    }
                }
                
                Text(label)
                    .foregroundColor(selectedValue == id ? .accentColor : .primary)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    RadioButtonField(id: "M", label: "Male", selectedValue: .constant(nil))
}
