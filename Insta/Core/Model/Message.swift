//
//  Message.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/04/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
// tạo mô hình dữ liệu cho tin nhắn
struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String// từ ai
    let toId: String// của ai
    let messaageText: String
    let timestamp: Timestamp// dấu thời gian của firebase
    
    var user: User?
    
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }
    // id đối tác trò chuyện
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    // kiểm tra xem có phải là người dùng hiện tại
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
}
