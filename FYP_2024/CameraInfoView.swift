//
//  CameraInfoView.swift
//  FYP_2024
//
//  Created by itst on 28/4/2024.
//

import SwiftUI

struct CameraInfomation {
    var cameraImageUrl: String
    var cameraID: String
    var cameraAddress: String
    var cameraPosition: String
    var numOfCatchStray: String
}


struct CameraInfoView: View {
    var cameraInfomation: CameraInfomation

    var body: some View {
        VStack {
            Image(systemName: cameraInfomation.cameraImageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 50)
            
            Text(cameraInfomation.cameraID)
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.blue)
                .fontWeight(.heavy)
                .padding(.top, 24)
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Address:\n" + cameraInfomation.cameraAddress)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.top, 24)
                
                Text("Coordinate:\n" + cameraInfomation.cameraPosition)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.top, 24)
                
                Text("Number of catch:\n" + cameraInfomation.numOfCatchStray)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.top, 24)
            }
            .padding(.horizontal)


        
            
            HStack(spacing: 40) {
               

                Button(action: {
                    
                    
                }) {
                    Image(systemName: "video.fill")
                        .foregroundColor(.red)
                }

               
            }
            .font(.largeTitle)
            .padding(.top, 30)
            
            Spacer()
        }
    }
}


struct CameraInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CameraInfoView(cameraInfomation: CameraInfomation(cameraImageUrl: "camera.circle", cameraID: "#4326", cameraAddress: "No. 21 Yuen Wo Road, Sha Tin", cameraPosition: "22°23'26.0\"N 114°11'52.9\"E", numOfCatchStray: "5"))
    }
}
