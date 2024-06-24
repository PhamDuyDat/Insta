//
//  CurrentUserProfileView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 01/04/2024.
//

import SwiftUI
struct CurrentUserProfileView: View {
    
    let user: User
   
    var body: some View {
        NavigationStack{
            ScrollView {
                //header
                ProfileViewHeader(user: user)
                //post grid view
              PostGridViews(user: user)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            AuthService.shared.signout()
                        } label: {
                            Text("Log out")
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USER[0])
}
