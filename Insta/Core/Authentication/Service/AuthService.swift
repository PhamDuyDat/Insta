//
//  AuthService.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 06/04/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase
// chứa tất cả các chức năng iên quan đến xác thực người dùng và liên kết với API
class AuthService {
    //Đây là một thuộc tính xuất bản được sử dụng để theo dõi trạng thái phiên đăng nhập của người dùng. Khi trạng thái đăng nhập thay đổi,
    //@Publisher này sẽ gửi thông báo để cập nhật giao diện người dùng.
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password : String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("DEBUG: Failed to log in user with error \(error.localizedDescription) ")
        }
    }
    
  // tạo dữ liệu người dùng
    @MainActor
    func createUser(email: String, password: String, userName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: Did creata user...")
            await uploadUserData(uid: result.user.uid, userName: userName, email: email)
            print("DEBUG: Did upload user data...")
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription) ")
        }
    }
    
    // lấy dữ liệu người dùng hiện tại khi đăng nhập
    //sử dụng để tải dữ liệu của người dùng đang đăng nhập.
    @MainActor
    func loadUserData() async throws{
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        //thông tin của người dùng đang đăng nhập sẽ được lấy và gán vào thuộc tính currentUser.
        self.currentUser = try await Userservice.fetchUser(withUid: currentUid)
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    // tải dữ liệu người đã được tạo lên firestore
    private func uploadUserData(uid: String, userName: String, email: String) async {
        let user = User(id: uid, userName: userName, email: email)
        self.currentUser = user
        // Thử mã hóa đối tượng User thành dữ liệu JSON để tải lên Firestore
        guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
        // Thực hiện việc tải dữ liệu lên Firestore
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
    }
}
