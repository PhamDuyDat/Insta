//
//  FeedView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 17/04/2024.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32){
                    ForEach(viewModel.posts) { post in
                        FeedCell(post: post)
//                        print("Post:", post) 
                    }
                }
               
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("Instagram_logo.svg")
                        .resizable()
                        .frame(width: 100, height: 32)
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
