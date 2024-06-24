//
//  User.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 13/03/2024.
//

import Foundation
import Firebase

struct User: Identifiable , Hashable , Codable {
    let id: String
    var userName: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    //kiểm tra xem người dùng hiện tại có phải là người dùng đang được đại diện bởi cấu trúc User không
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
}

extension User {
    static var MOCK_USER: [User] = [
        .init(
              id: NSUUID().uuidString,
              userName: "Datt",
              profileImageUrl: nil,
              fullname: "Pham Duy Dat",
              bio: "Hai Duong",
              email: "phamduya@gmail.com"
        ),
        .init(
              id: NSUUID().uuidString,
              userName: "Chii",
              profileImageUrl: nil,
              fullname: "Tran Quynh Chi",
              bio: "Ha Noi",
              email: "tranquynhb@gamil.com"
        ),
        .init(
             id: NSUUID().uuidString,
             userName: "Đức",
             profileImageUrl: nil,
             fullname: "Hoang Ngoc Duc",
             bio: "Thanh Hoa",
             email: "hongngocc@gmail.com"),
        .init(
             id: NSUUID().uuidString,
             userName: "Ngọc",
             profileImageUrl: nil,
             fullname: "Nguyen Huu Ngoc",
             bio: "Nam Dinh",
             email: "nguyenhuud@gmail.com"
        ),
        .init(
             id: NSUUID().uuidString,
             userName: "sơn",
             profileImageUrl: nil,
             fullname:  "Le Hong Son",
             bio: "Nam Dinh",
             email: "lehonge@gmail.com"
        ),
    ]
}

