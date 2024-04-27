import SwiftUI

struct FavFilterView: View {
    @State private var selectedBrands = Set<String>()
    @State private var selectedGender: String? // Default selection
    @State private var selectedNeutered: String? // Default selection
    @State private var selectedHealth: String? // Default selection
    @State private var ageBound: Double = 1
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedColors = Set<String>()
    
    let colors = ["Black", "White", "Gray", "Orange", "Brown", "Cream", "Calico", "Tortoiseshell", "Bicolor", "Siamese"]
    let brands = ["Royal Canin", "Purina", "Whiskas", "Hill's Science Diet", "Blue Buffalo", "Friskies", "Fancy Feast", "Meow Mix", "Iams", "Temptations"]
    let genders = ["N/A", "Male", "Female"]
    let neu = ["N/A", "Yes", "No"]
    let health = ["N/A", "Excellent", "Good", "Fair", "Hurt"]
    
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack {
                    BrandSection2(brands: brands, selectedBrands: $selectedBrands)
                    GenderSection2(genders: genders, selectedGender: $selectedGender)
                    
                    // Rest of the filter content goes here...
                    AgeSection2(ageBound: $ageBound)
                    ColorSection2(colors: colors, selectedColors: $selectedColors)
                    NeuteredSection2(neutered: neu, selectedNeutered: $selectedNeutered)
                    HealthSection2(health: health, selectedHealth: $selectedHealth)
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

struct BrandSection2: View {
    let brands: [String]
    @Binding var selectedBrands: Set<String>
    
    var body: some View {
        HStack {
            Text("Brand")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.leading, 15)
            Spacer()
            Button(action: {
                // Action to select all brands
                if selectedBrands.count == brands.count {
                    selectedBrands.removeAll()
                } else {
                    selectedBrands = Set(brands)
                }
            }) {
                Text("All")
                    .foregroundColor(selectedBrands.count == brands.count ? .blue : .blue)
                    .padding(.trailing, 15)
            }
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(brands, id: \.self) { brand in
                    Button(action: {
                        // Action to toggle this brand selection
                        if selectedBrands.contains(brand) {
                            selectedBrands.remove(brand)
                        } else {
                            selectedBrands.insert(brand)
                        }
                    }) {
                        Text(brand)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(selectedBrands.contains(brand) ? Color.yellow : Color.white)
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

struct GenderSection2: View {
    let genders: [String]
    @Binding var selectedGender: String?
    
    var body: some View {
        HStack {
            Text("Gender")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.leading, 15)
                .padding(.top ,10)
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        // Action to select this gender
                        self.selectedGender = gender
                    }) {
                        Text(gender)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(self.selectedGender == gender ? Color.yellow : Color.white)
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



struct NeuteredSection2: View {
    let neutered: [String]
    @Binding var selectedNeutered: String?
    
    var body: some View {
        HStack {
            Text("Neutered")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.leading, 15)
                .padding(.top ,10)
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(neutered, id: \.self) { neutered in
                    Button(action: {
                        // Action to select this gender
                        self.selectedNeutered = neutered
                    }) {
                        Text(neutered)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(self.selectedNeutered == neutered ? Color.yellow : Color.white)
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




struct HealthSection2: View {
    let health: [String]
    @Binding var selectedHealth: String?
    
    var body: some View {
        HStack {
            Text("Health")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.leading, 15)
                .padding(.top ,10)
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(health, id: \.self) { health in
                    Button(action: {
                        // Action to select this gender
                        self.selectedHealth = health
                    }) {
                        Text(health)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(self.selectedHealth == health ? Color.yellow : Color.white)
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






struct AgeSection2: View {
    @Binding var ageBound: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Age")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding([.leading, .top], 15)
            
            // Age range text
            Text("0 - \(Int(ageBound)) years")
                .foregroundColor(.black)
                .padding(.leading, 15)
            
            // Lower bound slider
            Slider(value: $ageBound, in: 1...25, step: 1)
                .padding(.horizontal)
        }
    }
}



struct ColorSection2: View {
    let colors: [String]
    @Binding var selectedColors: Set<String>
    
    // 自定義顏色
    func backgroundColor(for colorName: String) -> Color {
        switch colorName {
        case "Black":
            return .black
        case "White":
            return .white
        case "Gray":
            return .gray
        case "Orange":
            return .orange
        case "Brown":
            return Color.brown // 如果SwiftUI中沒有這個顏色，可能需要使用RGB值自定義
        case "Cream":
            return Color(red: 1, green: 0.99, blue: 0.82) // 需要自定義cream顏色
        case "Calico":
            // 提供自定義顏色，可能需要用Color(red:green:blue:)方法
            return Color(red: 0.82, green: 0.67, blue: 0.54)
        case "Tortoiseshell":
            return Color(red: 0.62, green: 0.32, blue: 0.17)
        case "Bicolor":
            // 需要自定義的顏色
            return Color(red: 0.5, green: 0.5, blue: 0)
        case "Siamese":
            return Color(red: 0.88, green: 0.80, blue: 0.65)
        default:
            return .black
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Color")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding([.leading, .top], 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(colors, id: \.self) { colorName in
                        Button(action: {
                            // 切換選擇狀態的動作
                            if selectedColors.contains(colorName) {
                                selectedColors.remove(colorName)
                            } else {
                                selectedColors.insert(colorName)
                            }
                        }) {
                            Text("")
                                .padding()
                                .frame(minWidth: 50, maxWidth: .infinity)
                                .background(backgroundColor(for: colorName)) // 使用新的函數名來避免衝突
                                .cornerRadius(5)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(selectedColors.contains(colorName) ? Color.yellow : Color.gray, lineWidth: 5)
                                )
                        }
                    }
                }
                .padding(.horizontal, 10)
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
