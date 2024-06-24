//
//  ImageUploader.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 08/04/2024.
//

import UIKit
import Firebase
import FirebaseStorage
// tải ảnh đại diện lên firebase(lưu ảnh lên firebase)
struct ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        // Chuyển đổi hình ảnh thành dữ liệu JPEG với chất lượng nén là 0.5
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return nil}
        let filename = NSUUID().uuidString
        // Xác định đường dẫn của tệp trong Firebase Storage
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            // Thực hiện tải lên dữ liệu hình ảnh lên Firebase Storage
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
