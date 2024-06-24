//
//  CircularProfileImageView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 08/04/2024.
//

import SwiftUI
import Kingfisher

enum profileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    var dimension: CGFloat {
        switch self {
        case .xxSmall:
            return 28
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 80
            
        }
    }
}
struct CircularProfileImageView: View {
    let user: User?
    let size: profileImageSize
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USER[0], size: .large )
}
