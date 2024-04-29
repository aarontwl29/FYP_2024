import SwiftUI

struct HightFilterView: View {
    @State private var selectedSeverity = Set<String>()
    @State private var selectedDayRange: String? // Default selection
    
    @Environment(\.presentationMode) var presentationMode
    
   
    let severity = ["Density", "Neutered", "Health"]
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack {
                    SeveritySection(severity: severity, selectedSeverity: $selectedSeverity)
                
                    SubmitBubbleForHight(buttonInfo: "Submit")
                }
                .padding(.top, 10)
                .navigationBarTitle("Filters", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        // Your code to handle the back action
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left") // This creates the back arrow
                    }
                )
            }
            
        }
    }
}

struct SeveritySection: View {
    let severity: [String]
    @Binding var selectedSeverity: Set<String>
    
    var body: some View {
        HStack {
            Text("Type")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.leading, 15)
            Spacer()
            Button(action: {
                // Action to select all brands
                if selectedSeverity.count == severity.count {
                    selectedSeverity.removeAll()
                } else {
                    selectedSeverity = Set(severity)
                }
            }) {
                Text("All")
                    .foregroundColor(selectedSeverity.count == severity.count ? .blue : .blue)
                    .padding(.trailing, 15)
            }
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(severity, id: \.self) { severity in
                    Button(action: {
                        // Action to toggle this brand selection
                        if selectedSeverity.contains(severity) {
                            selectedSeverity.remove(severity)
                        } else {
                            selectedSeverity.insert(severity)
                        }
                    }) {
                        Text(severity)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(selectedSeverity.contains(severity) ? Color.yellow : Color.white)
                            .cornerRadius(5)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        
        
    }
}



struct DayRangeSection: View {
    let dayRange: [String]
    @Binding var selectedDayRange: String?
    
    var body: some View {
        HStack {
            Text("Density")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.leading, 15)
                .padding(.top ,10)
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(dayRange, id: \.self) { gender in
                    Button(action: {
                        // Action to select this gender
                        self.selectedDayRange = gender
                    }) {
                        Text(gender)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(self.selectedDayRange == gender ? Color.yellow : Color.white)
                            .cornerRadius(5)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}


struct SubmitBubbleForHight: View {
    var buttonInfo: String
    var body: some View {
        VStack {
            Button(action: {
                // 寫上導航到其他頁面的程式碼
            }) {
                Text(buttonInfo)
                    .font(.title2)
                    .foregroundStyle(.blue)
                    .bold()
            }
            .frame(width:290 , height: 50)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}



#Preview {
    HightFilterView()
}
