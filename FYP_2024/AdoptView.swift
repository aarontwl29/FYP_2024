import SwiftUI

// 定义一个结构来存储联系人信息
struct PersonContact {
    var imageUrl: String
    var name: String
    var phone: String
    var email: String
    var organization: String
}

struct AdoptView: View {
    // 接受一个 PersonContact 类型的变量
    var contact: PersonContact

    var body: some View {
        VStack {
            Image(contact.imageUrl) // 使用联系人的图片
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 50)
            
            Text(contact.organization) // 显示联系人的名字
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.blue)
                .fontWeight(.heavy)
                .padding(.top, 24)
            
            Text(contact.name) // 显示联系人的名字
                .font(.title)
                .fontWeight(.medium)
                .padding(.top, 24)
            
            Text(contact.phone) // 显示联系人的电话
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.top, 18)
            
            Text(contact.email) // 显示联系人的电话
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.top, 2)
            
            // 这里可以加入显示电子邮件和组织的视图，根据你的设计添加即可
            
            HStack(spacing: 40) {
                Button(action: {
                    // 电话按钮的动作
                }) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.green)
                }

                Button(action: {
                    // 视频通话按钮的动作
                }) {
                    Image(systemName: "video.fill")
                        .foregroundColor(.blue)
                }

                Button(action: {
                    // 邮件按钮的动作
                }) {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.red)
                }
            }
            .font(.largeTitle)
            .padding(.top, 30)
            
            Spacer()
        }
    }
}

// 在预览中创建一个 PersonContact 实例来测试视图
struct AdoptView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptView(contact: PersonContact(imageUrl: "img_bl_icon1", name: "Alex Avalos", phone: "+852 5721 4211", email: "alex@example.com", organization: "HKSCDA"))
    }
}
