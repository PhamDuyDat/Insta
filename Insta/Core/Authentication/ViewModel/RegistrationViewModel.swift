//
//  RegistrationViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 06/04/2024.
//

import Foundation

//@MainActor
class RegistrationViewModel: ObservableObject {
    @Published var userName = ""
    @Published var email = ""
    @Published var password = ""
    // lấy thông tin chuyển đến createUser
   
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, userName: userName)
        
                self.userName = ""
                self.email = ""
                self.password = ""
    }
}
