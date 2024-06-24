//
//  LoginViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 06/04/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    // lấy thông tin từ email và password chuyển đến login 
    func signIn() async throws{
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
