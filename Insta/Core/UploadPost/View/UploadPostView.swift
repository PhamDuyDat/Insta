//
//  UploadPostView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 02/04/2024.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePickerPresented = false //xem ảnh có hiển thị hay không 
    @StateObject var viewModel = UploadPostViewModel()
    //ràng buộc
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    clearPostData()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("New Post")
                
                Spacer()
                
                Button{
                    Task {
                        try await viewModel.uploadPost(caption: caption)
                        clearPostData()
                    }
                } label: {
                    Text("Upload")
                }
            }
            .padding(.horizontal, 10)
            
            HStack(spacing: 8){
                if let image = viewModel.PostImage {
                   image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                  
                }
                
                TextField("Enter your captions...", text: $caption, axis: .vertical)
               
            }
            .padding()
            
            Spacer()
        }
        // khi onAppear đc kích hoạt thì picker ảnh sẽ xuất hiện ngay khi view đc mở
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    func clearPostData() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.PostImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
