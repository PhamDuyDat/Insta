//
//  PostGridViews.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 02/04/2024.
//

import SwiftUI
import Kingfisher

struct PostGridViews: View {
    @StateObject var viewModel: PostGirdViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostGirdViewModel(user: user))
    }
    
    private let gridItem: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),

    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        // hiện list ảnh đã đăng trong profile
        LazyVGrid(columns: gridItem, spacing: 2){
            ForEach(viewModel.posts) { post in
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridViews(user: User.MOCK_USER[0])
}
