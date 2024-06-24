//
//  ContentViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 06/04/2024.
//

//ContentViewModel chứa logic để quản lý trạng thái đăng nhập của người dùng và cập nhật giao diện người dùng tương ứng
import Foundation
import Firebase
import Combine

//ObservableObject là một protocol trong SwiftUI cho phép theo dõi sự thay đổi trong các thuộc tính và cập nhật giao diện người dùng tương ứng.

class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellabels = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
 
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSesssion in
            self?.userSession = userSesssion
        }
        .store(in: &cancellabels)
        
        //currentUser là một thuộc tính được sử dụng để lưu trữ thông tin về người dùng hiện tại trong ứng dụng của bạn.
        service.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellabels)
    }
}
