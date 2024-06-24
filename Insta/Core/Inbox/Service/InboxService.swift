//
//  InboxService.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 10/04/2024.
//

import Foundation
import Firebase

class InboxService {
    @Published var documentChanges = [DocumentChange]()
    
    func observeRecentMessage() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let query = Firestore.firestore().collection("messages").document(uid).collection("recent-messages").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({$0.type == .added || $0.type == .modified }) else {return}
            
            self.documentChanges = changes
        }
    }
}
