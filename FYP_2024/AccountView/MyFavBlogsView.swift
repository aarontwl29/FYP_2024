//
//  FavouriteBlogsView.swift
//  FYP_2024
//
//  Created by itst on 25/4/2024.
//

import SwiftUI

struct MyFavBlogsView: View {
    @State private var selectedTab = "Favourite"
    @State private var posts: [PostData] = []
    @State private var animals: [Animal] = []
    
    
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
                
                
                NavigationView {
                    ScrollView {
                        VStack {
                            ForEach(posts, id: \.postImageName) { post in
                                PostView(postData: post)
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                }
                .task {
                    await fetchAnimals()
                }
            }
            .navigationBarTitle(Text("Blog"), displayMode: .inline)
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
                
                let postData = PostData(profileImageName: profileImageName, userName: userName, postImageName: postImageName, likes: likes, description: description, isLiked:true, date: date)
                
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



#Preview {
    MyFavBlogsView()
}
