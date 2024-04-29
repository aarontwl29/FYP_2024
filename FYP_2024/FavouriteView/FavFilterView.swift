import SwiftUI

struct FavFilterView: View {
    @State private var selectedBrands = Set<String>()
    @State private var selectedGender: String? // Default selection
    @State private var selectedNeutered: String? // Default selection
    @State private var selectedHealth: String? // Default selection
    @State private var ageBound: Double = 1
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedColors = Set<String>()
    
    let colors = ["Black", "White", "Blue", "Gray", "Orange", "Brown", "Cream", "Calico", "Tortoiseshell", "Bicolor", "Siamese"]
    let brands = ["Royal Canin", "Purina", "Whiskas", "Hill's Science Diet", "Blue Buffalo", "Friskies", "Fancy Feast", "Meow Mix", "Iams", "Temptations"]
    let genders = ["N/A", "Male", "Female"]
    let neu = ["N/A", "Yes", "No"]
    let health = ["N/A", "Excellent", "Good", "Fair", "Hurt"]
    
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack {
                    BrandSection(brands: brands, selectedBrands: $selectedBrands)
                    GenderSection(genders: genders, selectedGender: $selectedGender)
                    
                    // Rest of the filter content goes here...
                    AgeSection(ageBound: $ageBound)
                    ColorSection(colors: colors, selectedColors: $selectedColors)
                    NeuteredSection(neutered: neu, selectedNeutered: $selectedNeutered)
                    HealthSection(health: health, selectedHealth: $selectedHealth)
                    SubmitBubble2(buttonInfo: "Submit")
                }
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




struct FavFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FavFilterView()
    }
}



struct SubmitBubble2: View {
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
