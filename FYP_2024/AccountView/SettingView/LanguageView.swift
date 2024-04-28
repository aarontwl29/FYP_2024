import SwiftUI

struct LanguageView: View {
    @State private var selectedLanguage = "English"

    var body: some View {
        NavigationView{
            List {
                ForEach(["繁體中文", "繁體中文（香港）", "English", "Mandarin", "Hindi", "Indonesian", "Portuguese", "Urdu", "Bengali", "Russian", "Spanish", "Japanese", "Amharic", "Filipino", "Arabic", "Vietnamese", "French", "Persian", "Turkish", "German", "Thai"], id: \.self) { language in
                    Button(action: {
                        // 更新選擇的語言
                        self.selectedLanguage = language
                    }) {
                        HStack {
                            Text(language)
                            Spacer()
                            // 如果這個語言被選擇了，就顯示一個對勾
                            if language == selectedLanguage {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .foregroundColor(.black) // 讓文字保持原本的顏色
                }
                
                
                // 刪除這個 Spacer()，確保列表可以填滿整個空間
            }
        }
        .padding(.top, 5)
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView()
    }
}

