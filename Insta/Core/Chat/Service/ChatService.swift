//
//  ChatService.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 10/04/2024.
//

import Foundation
import Firebase

struct ChatService {
    
    let chatPartner: User
    // gửi tin nhắn lưu tin nhắn thành messageId lưu và firebase vào đoạn hội thoại của cả người nhận và người gửi
     func sendMessage(_ messageText: String) {
         // lấy uid người dùng hiện tại
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
         // lấy id đối tác trò chuyện
        let chatPartnerId = chatPartner.id
        
        let currentUseRef = Firestore.firestore().collection("messages").document(currentUid).collection(chatPartnerId).document()
        
        let chatPartnerRef = Firestore.firestore().collection("messages").document(chatPartnerId).collection(currentUid)
         
         let recenCurrentUserRef = Firestore.firestore().collection("messages").document(currentUid).collection("recent-messages").document(chatPartnerId)
         
         let recentPartnerRef = Firestore.firestore().collection("messages").document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUseRef.documentID
        
        let message = Message(messageId: messageId, fromId: currentUid, toId: chatPartnerId, messaageText: messageText, timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else {return}
        
        currentUseRef.setData(messageData)
        
        chatPartnerRef.document(messageId).setData(messageData)
         // lưu data
         recenCurrentUserRef.setData(messageData)
         
         recentPartnerRef.setData(messageData)
    }
    
    // ngay khi có tin nhắn được thêm vào, nó sẽ gửi mọi thônng tin xuống app và giải mã tất cả
    func observeMessages(completion: @escaping([Message]) -> Void) {
        // id người dùng hiện tại
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        // id đối tác
        let chatPartnerId = chatPartner.id
        
        let query = Firestore.firestore().collection("messages")
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        // lấy ra tin nhắn nagy khi đc thêm vào firebase
        // lắng nghe mọi thay đổi trong datebase chỉ quan tâm đến những tin nhắn đc thêm vào
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
            // lấy lại dữ liệu từ những thay đổi
            var messages = changes.compactMap({try? $0.document.data(as: Message.self)})
            
            for (index,message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
