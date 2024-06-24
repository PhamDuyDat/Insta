//
//  ProfileViewHeader.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 02/04/2024.
//

import SwiftUI

struct ProfileViewHeader: View {
    let user: User
    
    @State private var showEditprofile = false
    
    var body: some View {
        VStack(spacing: 10) {
            //pic and starts

            HStack {
                
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                HStack(spacing: 8) {
                    UserStartView(value: 0, title: "Posts")
                    
                    UserStartView(value: 0, title: "Followers")
                    
                    UserStartView(value: 0, title: "Following")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
            //name and bio
            VStack(alignment: .leading, spacing: 4) {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
//                Text(user.userName)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // action button
            
            Button {
                if user.isCurrentUser {
                    showEditprofile.toggle()
                } else {
                    print("folow user...")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profie" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundColor(user.isCurrentUser ? .black : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
            }
            Divider()
        }
        .fullScreenCover(isPresented: $showEditprofile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileViewHeader(user: User.MOCK_USER[0])
}
