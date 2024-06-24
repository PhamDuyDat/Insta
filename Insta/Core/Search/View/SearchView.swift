//
//  SearchView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 11/03/2024.
//

import SwiftUI

//struct SearchView: View {
//    @State private var searchText = ""
//    @StateObject var viewModel = SreachViewModel()
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVStack(spacing: 14){
//                    ForEach(viewModel.users) { user in
//                        NavigationLink(value: user) {
//                            HStack {
//                                CircularProfileImageView(user: user, size: .small)
//                                
//                                VStack(alignment: .leading){
//                                    Text(user.userName)
//                                        .fontWeight(.semibold)
//                                    if let fullname = user.fullname {
//                                        Text(fullname)
//                                    }
//                                }
//                                .font(.footnote)
//                                
//                                Spacer()
//                            }
//                        }
//                        .foregroundColor(.black)
//                        .padding(.horizontal)
//                    }
//                }
//                .padding(.top, 8)
//                .searchable(text: $searchText, prompt: "Search...")
//            }
//            .navigationDestination(for: User.self, destination: { user in  ProfileView(user: user)})
//            .navigationTitle("Search")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SreachViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 14){
                    ForEach(viewModel.users.filter {
                        searchText.isEmpty || $0.userName.localizedCaseInsensitiveContains(searchText)
                    }) { user in
                        NavigationLink(destination: ProfileView(user: user)) {
                            HStack {
                                CircularProfileImageView(user: user, size: .small)
                                
                                VStack(alignment: .leading){
                                    Text(user.userName)
                                        .fontWeight(.semibold)
                                    if let fullname = user.fullname {
                                        Text(fullname)
                                    }
                                }
                                .font(.footnote)
                                
                                Spacer()
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
