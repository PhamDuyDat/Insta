//
//  UploadPostViewModel.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 04/04/2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    
    //khi người dùng chọn ảnh từ picker thì selectedImange sẽ được cập nhật
    //Khi giá trị của selectedImage thay đổi, closure trong {...} sẽ được gọi
    //và nó chứa một Task để chạy một hàm không đồng bộ (loadImage(fromItem:)) để tải ảnh từ selectedImage.
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage (fromItem: selectedImage )}}
    }
    
    @Published var PostImage: Image?
    
    private var uiImage: UIImage?
    
    // hàm nhận dối tượng PhotosPickerItem là đối tượng đầu vào(ảnh người dùng đã chọn)
    func loadImage (fromItem item: PhotosPickerItem?) async {
        // kiểm tra xem item có giá trị hay không(có ảnh hay ko)
        guard let item = item else { return }
        //Phương thức này trả về dữ liệu của ảnh dưới dạng Data. Nếu việc tải dữ liệu thành công, data sẽ chứa dữ liệu của ảnh,nếu ko hàm sẽ end
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        //Dòng này sử dụng dữ liệu Data đã tải được để tạo một đối tượng UIImage.
        //Nếu việc tạo UIImage thành công, uiImage sẽ chứa hình ảnh; nếu không, hàm sẽ kết thúc và không làm gì cả.
        guard let uiImage = UIImage(data: data) else { return }
        //Điều này có nghĩa là ảnh đã được chọn sẽ được hiển thị trên giao diện thông qua việc gán vào biến PostImage.
        self.uiImage = uiImage
        self.PostImage = Image(uiImage: uiImage)
        //PosrImage sẽ là ảnh người dùng đã chọn từ picker
    }
    
    // đẩy dữ liệu lên Firebase
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uiImage = uiImage else {return}
        
        let postRef = Firestore.firestore().collection("posts").document()
        // Thử tải lên hình ảnh của bài đăng lên Firestore và lấy URL của hình ảnh
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else {return}
        // Tạo một đối tượng Post với thông tin được cung cấp và URL của hình ảnh
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Timestamp())
        // Mã hóa đối tượng Post thành dữ liệu JSON
        guard let encodePost = try? Firestore.Encoder().encode(post) else {return}
        
        try await postRef.setData(encodePost)
    }
}


