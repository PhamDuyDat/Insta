//
//  InboxViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/04/2024.
//

import Foundation
import Combine
import Firebase

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
   
    private var cancellabels = Set<AnyCancellable>()
    private let service = InboxService()
    
    init() {
        setupSub()
        service.observeRecentMessage()
    }
    
    private func setupSub() {
        AuthService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellabels)
        
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitialMessages(fromChanges: changes)
        }.store(in: &cancellabels)
    }
    private func loadInitialMessages(fromChanges changes : [DocumentChange]) {
        var messages = changes.compactMap({try? $0.document.data(as: Message.self)})
        
        for i in 0 ..< messages.count{
            let message = messages[i]
            
            Userservice.fetch(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
}
