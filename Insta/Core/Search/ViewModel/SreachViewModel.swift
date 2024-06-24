//
//  SreachViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 07/04/2024.
//

import Foundation

class SreachViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await Userservice.fetchAllUsers()
    }
}

