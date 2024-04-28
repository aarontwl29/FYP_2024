import SwiftUI

struct PrivacyView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.2.badge.key.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text("Privacy")
                .font(.title)
                .fontWeight(.bold)
            Text("Stray Sentinel is more than an app, it's a mission-driven platform designed for the welfare of stray cats and dogs. Whether community residents, animal lovers, or rescue organizations, everyone can improve the quality of life of stray animals through this app. If you see a stray animal on the road, you can use Stray Sentinel to report its location so other users and rescue organizations can know and take action. You can also share helpful resources, such as how to safely help these animals, how to provide respite care, or how to contact local animal services.")
                .font(.body)
                .foregroundColor(.secondary)
                .padding() // 增加內邊距讓文字不會太靠邊
            .padding()
            Spacer()
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
