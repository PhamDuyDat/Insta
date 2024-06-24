//
//  Post.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 01/04/2024.
//

import Foundation
import Firebase


struct Post: Identifiable, Hashable, Codable {
    var id: String
    let ownerUid: String// id người dùng đăng bài
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
}

extension Post {
   static  var MOCK_POST: [Post] = [
    .init(
        id: NSUUID().uuidString,
        ownerUid: NSUUID().uuidString,
        caption: "So Beautiful",
        likes: 300,
        imageUrl: "anh-dep-0",
        timestamp: Timestamp(),
        user: User.MOCK_USER[0]
    ),
    .init(
        id: NSUUID().uuidString,
        ownerUid: NSUUID().uuidString,
        caption: "Wowwww",
        likes: 100,
        imageUrl: "anh-dep-4",
        timestamp: Timestamp(),
        user: User.MOCK_USER[1]
    ),
    .init(
        id: NSUUID().uuidString,
        ownerUid: NSUUID().uuidString,
        caption: "my life",
        likes: 98,
        imageUrl: "anh-dep-3",
        timestamp: Timestamp(),
        user: User.MOCK_USER[3]
    ),
    .init(
        id: NSUUID().uuidString,
        ownerUid: NSUUID().uuidString,
        caption: "Caption is nothing?",
        likes: 10,
        imageUrl: "anh-dep-9",
        timestamp: Timestamp(),
        user: User.MOCK_USER[2]
    ),
    .init(
        id: NSUUID().uuidString,
        ownerUid: NSUUID().uuidString,
        caption: "nothing in here",
        likes: 99,
        imageUrl: "anh-dep-10",
        timestamp: Timestamp(),
        user: User.MOCK_USER[4]
    ),
   ]
}
