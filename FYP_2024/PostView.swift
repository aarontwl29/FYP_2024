import SwiftUI

// 定義帖子數據結構
struct Post {
    var username: String
    var imageUrl: String
    var likes: Int
    var comments: Int
    var content: String
}

struct PostView: View {
    // 模擬數據
    let posts: [Post] = [
        Post(username: "user1", imageUrl: "image1", likes: 120, comments: 30, content: "A beautiful stray cat found in the park."),
        Post(username: "user2", imageUrl: "image2", likes: 150, comments: 45, content: "Found this little puppy outside the supermarket."),
        Post(username: "user3", imageUrl: "image3", likes: 89, comments: 22, content: "This stray dog needs a home!"),
        Post(username: "user4", imageUrl: "image4", likes: 200, comments: 60, content: "Help us find a family for this lovely kitten."),
        Post(username: "user5", imageUrl: "image5", likes: 300, comments: 120, content: "Spotted a group of stray cats near downtown."),
        Post(username: "user6", imageUrl: "image6", likes: 450, comments: 150, content: "These two strays were found cuddling in a box."),
        Post(username: "user7", imageUrl: "image7", likes: 500, comments: 200, content: "Stray puppy playing in the field."),
        Post(username: "user8", imageUrl: "image8", likes: 600, comments: 250, content: "Found a stray cat with a beautiful coat."),
        Post(username: "user9", imageUrl: "image9", likes: 750, comments: 300, content: "This old dog has been a stray for years."),
        Post(username: "user10", imageUrl: "image10", likes: 800, comments: 350, content: "A stray dog and her puppies need your help.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(posts, id: \.username) { post in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(post.username)
                                .font(.headline)
                                .padding(.leading, 10)
                            Spacer()
                            Button("Subscribe") {
                                // 實現訂閱功能
                            }
                            .padding(.trailing, 10)
                        }
                        
                        // 圖片示例（這裡只是示例，你需要使用實際的圖片）
                        Image("image1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                        
                        HStack {
                            Button(action: {
                                // 實現點讚功能
                            }) {
                                Label("\(post.likes)", systemImage: "heart")
                            }
                            .buttonStyle(.plain)
                            .padding(.leading, 10)
                            
                            Button(action: {
                                // 實現評論功能
                            }) {
                                Label("\(post.comments)", systemImage: "message")
                            }
                            .buttonStyle(.plain)
                            .padding(.leading, 10)
                        }
                        
                        Text(post.content)
                            .padding(.all, 10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .padding(.all, 10)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
