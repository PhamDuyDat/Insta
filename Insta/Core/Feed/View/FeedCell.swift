//
//  FeedCell.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/03/2024.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @State var likePost = false
    @State var heart = false
    var post: Post

    @State var like = 0
    func Like() {
        if likePost {
            like += 1
        } else {
            like -= 1
        }
    }
    var body: some View {
        VStack {
            // image + username
            HStack {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .xSmall)
                    Text (user.userName)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        Spacer()
                }
            }
            .padding(.leading, 8)
            
            //post image
            
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
                .onTapGesture(count: 2, perform: {
//                    likePost.toggle()
                    likePost = !likePost;
                    print(likePost)
//                    self.Like()
                    Like()
                })
            
            //action button
            HStack(spacing: 16) {
                Button {
                    likePost.toggle()// chuyển từ true sang false và ngược lại
                    print(likePost)
                    Like()
                    
                } label: {
                    Image(systemName: likePost ? "heart.fill" : "heart") // turner
                        .imageScale(.large)
                        .foregroundColor(likePost ? .red : .black)
//                    if likePost {
//                        Image(systemName: "heart.fill")
//                            .imageScale(.large)
//                            .foregroundColor(.red)
//                    }else {
//                        Image(systemName: "heart")
//                            .imageScale(.large)
//                    }
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)
            //like label
            
            Text("\(like) Likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
            //caption label
            HStack {
                Text("\(post.user? .userName ?? "")  ").fontWeight(.semibold) + Text(post.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 10)
            .padding(.top, 1)

        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POST[0])
}
