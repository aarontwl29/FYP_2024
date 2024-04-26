import SwiftUI

struct BlogView: View {
    
    @State private var posts: [PostData] = []
    @State private var animals: [Animal] = []
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(posts, id: \.postImageName) { post in
                        PostView(postData: post)
                            .padding(.bottom, 8)
                    }
                }
            }
            .navigationBarTitle(Text("Blogs"), displayMode: .inline)
        }
        .task {
            await fetchAnimals()
        }
    }
    
    func fetchAnimals() async {
        do {
            let fetchedAnimals = try await performAPICall_Animals()
            animals = fetchedAnimals
            
            var postsData: [PostData] = []
            for animal in animals {
                let profileImageName = "img_bl_icon\(Int.random(in: 1...6))"
                let userName = animal.nickName
                let postImageName = "img_bl_content\(Int.random(in: 1...6))"
                let likes = "Liked by \(["LucasNG_", "JessWong", "MarkChen", "AnnieHo", "LeoKwok", "Samantha"].randomElement()!) and \(Int.random(in: 5000...50000)) others"
                let description = animal.description
                let date = "2024-04-25 \(String(format: "%02d:%02d", Int.random(in: 0...23), Int.random(in: 0...59)))"
                
                let postData = PostData(profileImageName: profileImageName, userName: userName, postImageName: postImageName, likes: likes, description: description, date: date)
                postsData.append(postData)
            }
            DispatchQueue.main.async {
                self.posts = postsData
            }
        } catch {
            print("Error fetching animals: \(error)")
        }
    }
}
    
struct PostView: View {
    @State var postData: PostData
    
    var body: some View {
        VStack(alignment: .leading) {
            PostHeaderView(postData: postData)
            Image(postData.postImageName)
                .resizable()
                .scaledToFit()
                .onTapGesture(count: 2) {
                    postData.isLiked.toggle()
                }
            PostActionsView(postData: $postData)
            PostDescriptionView(postData: postData)
            CommentsView(postData: $postData)
            Spacer()
            HStack {
                Spacer()
                Text(postData.date)  // 顯示日期和時間
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                    .padding(.bottom, 5)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 3, x: 1, y: 1)
    }
}

// 留言和其他組件的代碼照舊保留，若需要查看完整結構，請告知。



struct PostHeaderView: View {
    var postData: PostData
    
    var body: some View {
        HStack {
            ProfileImageView(profileImageName: postData.profileImageName)
            Text(postData.userName)
                .font(.headline)
                .padding(.vertical, 4)
                
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 2)
        .padding(.horizontal, 8)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct ProfileImageView: View {
    var profileImageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(.red)
                .frame(width: 40, height: 40)
            Image(profileImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .clipShape(Circle())
        }
    }
}

struct PostActionsView: View {
    @Binding var postData: PostData
    
    var body: some View {
        HStack {
            Button(action: {
                postData.isLiked.toggle()
            }) {
                Image(systemName: postData.isLiked ? "heart.fill" : "heart")
                    .foregroundColor(postData.isLiked ? .red : .black)
                    .font(.title2)
            }
            .padding(.trailing, 5)
            
            Button(action: {
                postData.showingComments.toggle()  // 切換顯示留言區
            }) {
                Image(systemName: "message")
                    .font(.title2)
            }
            
            Spacer()
            
            Button(action: {
                postData.isBookmarked.toggle()
            }) {
                Image(systemName: postData.isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(.black)
                    .font(.title2)
            }
        }
        .padding(.top, 2)
        .padding(.horizontal, 5)
        .font(.title2)
    }
}



struct PostDescriptionView: View {
    var postData: PostData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                Text(postData.likes)
                    .font(.footnote)
                    .bold()
                    
            }.padding(.bottom, 3).padding(.leading, -4)
            Text(postData.description)
                .font(.footnote)
                .padding(.bottom, 5)
        }
        .padding(.top, 2)
        .padding(.horizontal, 10)
    }
}

struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}

struct PostData {
    var profileImageName: String
    var userName: String
    var postImageName: String
    var likes: String
    var description: String
    var isLiked: Bool = false
    var isBookmarked: Bool = false
    var comments: [Comment] = [
        Comment(content: "I'm interested >.<", userId: "HeiYu", date: "2024-04-24"),
        Comment(content: "Oh my god! It's poor.", userId: "Aaronr31PL", date: "2024-04-24")
    ]  // 預設留言
    var showingComments: Bool = false
    var date: String  // 新增日期和時間
}



struct CommentsView: View {
    @Binding var postData: PostData
    @State private var newComment: String = ""
    
    var body: some View {
        VStack {
            if postData.showingComments {
                List(postData.comments, id: \.content) { comment in
                    HStack {
                        Text(comment.content)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()

                        VStack(alignment: .trailing) {
                            Text(comment.userId)
                                .font(.subheadline)
                                .foregroundColor(.black).bold()
                            Text(comment.date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
                .frame(height: 200)  // 控制留言列表的高度

                HStack {
                    TextField("Add a comment...", text: $newComment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minWidth: 0, maxWidth: .infinity)

                    Button("Send") {
                        let newCommentEntry = Comment(content: newComment, userId: "Me", date: Date().formatted(date: .abbreviated, time: .omitted))  // 假設當前用戶 ID 是 currentUser
                        postData.comments.append(newCommentEntry)  // 新增留言到列表
                        newComment = ""  // 清空輸入框
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 0.1)
                    )
                }
                .padding()
            }
        }
    }
}



struct Comment {
    var content: String
    var userId: String
    var date: String
}
