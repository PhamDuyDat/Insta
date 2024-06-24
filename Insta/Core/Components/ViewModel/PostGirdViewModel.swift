//
//  PostGirdViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 08/04/2024.
//

import Foundation

class PostGirdViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    
    init(user: User) {
        self.user = user
        
        Task {try await fetchUserPosts() }
    }
    
    @MainActor
    
    func fetchUserPosts() async throws{
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        //Sau khi lấy được danh sách bài đăng, vòng lặp for được sử dụng để gắn người dùng (user) vào mỗi bài đăng trong mảng posts.
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}
