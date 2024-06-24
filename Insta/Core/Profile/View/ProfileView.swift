//
//  ProfileView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 05/03/2024.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var body: some View {
            ScrollView {
                //header
             ProfileViewHeader(user: user)
                //post grid view
               PostGridViews(user: user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
       
    }


#Preview {
    ProfileView(user: User.MOCK_USER[0])
}
