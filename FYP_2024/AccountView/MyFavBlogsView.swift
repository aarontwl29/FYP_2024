//
//  FavouriteBlogsView.swift
//  FYP_2024
//
//  Created by itst on 25/4/2024.
//

import SwiftUI

struct MyFavBlogsView: View {
    @State private var selectedTab = "Favourite"
    @State private var posts: [PostData] = [
        PostData(profileImageName: "img_bl_icon1", userName: "HKSCDA", postImageName: "img_bl_content1", likes: "Liked by LucasNG_ and 44,872 others", description: "As we enter early winter, the weather is gradually getting chillier. When you see stray cats and dogs on the street cowering away from the cold, have you ever thought about helping them?", isLiked: true, comments: [
            Comment(content: "I'm interested >.<", userId: "HeiYu", date: "2024-04-24"),
            Comment(content: "Oh my god! It's poor.", userId: "Aaronr31PL", date: "2024-04-24"),
            Comment(content: "Nice", userId: "Me", date: "2024-04-30")
        ], date: "2024-04-25 08:00")
    ]
    @State private var postsSave: [PostData] = [
        PostData(profileImageName: "img_bl_icon2", userName: "HKDR_HK", postImageName: "img_bl_content2", likes: "Liked by JessWong and 22,567 others", description: "Today we helped a litter of kittens get the warm shelter they desperately need. Every small action counts.", isBookmarked: true, date: "2024-04-25 12:00")
    ]

    var filteredPosts: [PostData] {
        posts.filter { $0.isLiked }
    }

    var filteredPostsSave: [PostData] {
        postsSave.filter { $0.isBookmarked }
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select", selection: $selectedTab) {
                    Text("Favourite").tag("Favourite")
                    Text("Save").tag("Save")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(minHeight: 44)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 0).fill(Color.white))
                        .padding(.vertical, 5)
                )
                .padding(.horizontal, 10)
                .onChange(of: selectedTab) { _ in
                    // 選擇切換後，切換顯示的內容
                }

                ScrollView {
                    VStack {
                        if selectedTab == "Favourite" {
                            ForEach(filteredPosts, id: \.postImageName) { post in
                                PostView(postData: post)
                                    .padding(.bottom, 8)
                            }
                        } else {
                            ForEach(filteredPostsSave, id: \.postImageName) { post in
                                PostView(postData: post)
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Blog"), displayMode: .inline)
        }
    }
}




#Preview {
    MyFavBlogsView()
}











//    func fetchAnimals() async {
//        do {
//            let fetchedAnimals = try await performAPICall_Animals()
//            animals = fetchedAnimals
//
//            var postsData: [PostData] = []
//            for animal in animals {
//                let profileImageName = "img_bl_icon\(Int.random(in: 1...6))"
//                let userName = animal.nickName
//                let postImageName = "img_bl_content\(Int.random(in: 1...6))"
//                let likes = "Liked by \(["LucasNG_", "JessWong", "MarkChen", "AnnieHo", "LeoKwok", "Samantha"].randomElement()!) and \(Int.random(in: 5000...50000)) others"
//                let description = animal.description
//                let date = "2024-04-25 \(String(format: "%02d:%02d", Int.random(in: 0...23), Int.random(in: 0...59)))"
//
//                let postData = PostData(profileImageName: profileImageName, userName: userName, postImageName: postImageName, likes: likes, description: description, isLiked:true, date: date)
//
//                postsData.append(postData)
//            }
//            DispatchQueue.main.async {
//                self.posts = postsData
//            }
//        } catch {
//            print("Error fetching animals: \(error)")
//        }






//                .task {
//                    await fetchAnimals()
//                }
