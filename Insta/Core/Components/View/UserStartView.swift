//
//  UserStartView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 06/03/2024.
//

import SwiftUI

struct UserStartView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)

            Text(title)
                .font(.footnote)

        }
        .frame(width: 76)
    }
}

#Preview {
    UserStartView(value: 12, title: "Posts")
}
