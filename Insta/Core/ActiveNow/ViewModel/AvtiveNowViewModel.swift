//
//  AvtiveNowViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 10/04/2024.
//


import Foundation
import Firebase

@MainActor
class AvtiveNowViewModel : ObservableObject {
    @Published var user = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    func fetchAllUsers() async throws{
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let user = try await Userservice.fetchAllUsers()
        self.user = user.filter({ $0.id != currentUid})
    }
}

