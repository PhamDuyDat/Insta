//
//  PostService.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 08/04/2024.
//

import Firebase

struct PostService {
    
    private static let postsCollection =  Firestore.firestore().collection("posts")
    
    //Phương thức này được sử dụng để lấy tất cả các bài đăng từ bộ sưu tập "posts" trong Firestore.
    static func fetchFeedPosts() async throws -> [Post] {
        // Lấy tất cả các tài liệu từ bộ sưu tập "posts" trong Firestore
        
//        let snapshot = try await postsCollection.getDocuments()
        // Chuyển đổi tài liệu Firestore thành mảng các Post objects
        
//        var posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
//        print("PostService fetchFeedPosts: %d", posts.count);
        let snapshot = try await postsCollection.order(by: "timestamp", descending: true).getDocuments() // Sắp xếp theo trường timestamp từ mới đến cũ
            
            var posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            print("PostService fetchFeedPosts return: %d", ownerUid);
            // Gọi hàm fetchUser từ UserService để lấy thông tin người dùng sở hữu bài đăng
            let postUser = try await Userservice.fetchUser(withUid: ownerUid)
            print("PostService fetchFeedPosts1 return: %d", postUser.userName);
            posts[i].user = postUser
        }
        return posts
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        // Lấy tất cả các bài đăng của một người dùng dựa trên ID của họ
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        
        return try snapshot.documents.compactMap({try $0.data(as: Post.self)})
    }
}
