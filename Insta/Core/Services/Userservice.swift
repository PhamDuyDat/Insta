//
//  Userservice.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 07/04/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Userservice {
    
    //Hàm này nhận vào một uid dưới dạng chuỗi và thực hiện các thao tác để tìm và trả về dữ liệu của người dùng tương ứng từ Firestore
    
    static func fetchUser(withUid uid : String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
//    static var listeners = [String: ListenerRegistration]()
//    static var y = 1
//        static func fetchUser(withUid uid: String) async throws -> User {
//            print("in \(y)")
//            y += 1
//            // Check if listener already exists for this uid, if yes, remove it
//            if let listener = listeners[uid] {
//                listener.remove()
//                listeners.removeValue(forKey: uid)
//            }
//       
//            
//            // Set up listener to observe changes in user document
//            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
//            
//            guard let userData = snapshot.data() else {
//                throw NSError(domain: "User data is nil", code: 500, userInfo: nil)
//            }
//            
//            if let user = try? Firestore.Decoder().decode(User.self, from: userData) {
//                return user
//            } else {
//                throw NSError(domain: "Failed to decode user data", code: 500, userInfo: nil)
//            }
//        }
    //tải danh sách tất cả người dùng từ Firestore.
   static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
       return snapshot.documents.compactMap( { try? $0.data(as: User.self) })
    }
    
    static func fetch(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("messages").document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
    }
}
