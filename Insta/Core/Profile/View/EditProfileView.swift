//
//  EditProfileView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 07/04/2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    
                    Text("Edit profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                        
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
        }
        
        PhotosPicker(selection: $viewModel.selectedImage) {
            VStack {
                if let image = viewModel.profileImage {
                    image
                        .resizable()
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                } else {
                    CircularProfileImageView(user: viewModel.user, size: .large)
                }
                
                Text("Edit profile picture")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Divider()
            }
        }
        .padding(.vertical, 10)
        
        VStack {
            EditProflieRowView(title: "Name", placeholder: "Enter your name...", text: $viewModel.fullname)
            EditProflieRowView(title: "Bio", placeholder: "Enter your bio...", text: $viewModel.bio)
        }
        Spacer()
    }
}


struct EditProflieRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USER[0])
}
