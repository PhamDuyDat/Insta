//
//  FeedViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 17/04/2024.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()

    
    init() {
        Task{ try await fetchPost()}
    }
    
    @MainActor
    func fetchPost() async throws {
        self.posts = try await PostService.fetchFeedPosts()
        print("Fetched posts:", self.posts)
    }
}
