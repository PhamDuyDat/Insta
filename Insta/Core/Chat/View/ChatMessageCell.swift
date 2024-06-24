//
//  ChatMessageCell.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/04/2024.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: Message
 
    
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    var body: some View {
        HStack{
            // kiểm tra xem có phải người dùng hiện tại hay ko 
            if isFromCurrentUser {
                Spacer()
                
                Text(message.messaageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBuubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8){
                    
                    Text(message.messaageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBuubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

//#Preview {
//    ChatMessageCell(isFromCurrentUser: true)
//}
