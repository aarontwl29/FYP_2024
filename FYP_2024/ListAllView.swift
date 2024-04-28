//
//  ListAllView.swift
//  FYP_2024
//
//  Created by itst on 29/4/2024.
//

import SwiftUI

struct ListAllView: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var showingDetails = false  // 用於控制是否顯示詳細信息視圖
    
    let petCardViews: [PetCardView] = [
        PetCardView(
            imageName: "image1",
            nickName: "Buddy",
            breed: "Labrador",
            colors: "Yellow",
            gender: "Male",
            size: "Large",
            address: "123 Pet St, New York",
            date: "20/04/2024"
        ),
        PetCardView(
            imageName: "image2",
            nickName: "Whiskers",
            breed: "Siamese",
            colors: "Brown, Black",
            gender: "Female",
            size: "Small",
            address: "234 Cat Ave, Boston",
            date: "21/04/2024"
        ),
        PetCardView(
            imageName: "image3",
            nickName: "Fluffy",
            breed: "Rabbit",
            colors: "White",
            gender: "Male",
            size: "Small",
            address: "345 Bunny Blvd, Chicago",
            date: "22/04/2024"
        ),
        PetCardView(
            imageName: "image1",
            nickName: "Buddy",
            breed: "Labrador",
            colors: "Yellow",
            gender: "Male",
            size: "Large",
            address: "123 Pet St, New York",
            date: "20/04/2024"
        ),
        PetCardView(
            imageName: "image2",
            nickName: "Whiskers",
            breed: "Siamese",
            colors: "Brown, Black",
            gender: "Female",
            size: "Small",
            address: "234 Cat Ave, Boston",
            date: "21/04/2024"
        ),
        PetCardView(
            imageName: "image3",
            nickName: "Fluffy",
            breed: "Rabbit",
            colors: "White",
            gender: "Male",
            size: "Small",
            address: "345 Bunny Blvd, Chicago",
            date: "22/04/2024"
        )]
    
    //實現新增，創立一個array,裡面創作10個PetCardView, Data你可以偽造，例如PetCardView(imageName: "image\(index + 1)",nickName: "Lucas",breed: "Mixed Breed",colors: "Black, White",gender: "Male",size: "Medium (15-25 kg)",address: "Kpousódou 21, Athína 115 28, Elláda", date: "11/04/2024")
    
    var body: some View {
        VStack {
            TextField("Search for stray cats", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
            
            Button(action: {
                self.isFilterViewPresented = true
            }) {
                Label("Filter", systemImage: "slider.horizontal.3")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .sheet(isPresented: $isFilterViewPresented) {
                FavFilterView()
            }
            
            ScrollView {
                VStack(spacing: 15) {
                    //實現更改，更改Loop的內容，裡面內容改為PetCardView的array
                    ForEach(petCardViews, id: \.nickName) { petCardView in
                        petCardView
                            .onTapGesture {
                                self.showingDetails = true
                            }
                            .sheet(isPresented: $showingDetails) {
                                // 顯示詳細信息視圖
                                AnimalDetailsView(isLiked: false, selectedAnnotation: .constant(nil)).padding(.top,20)
                            }
                    }
                    
                    
                }.padding(.top, 10)
            }
            .padding(.top, -10)
        }.padding(.top, 20)
    }
}

#Preview {
    ListAllView()
}
