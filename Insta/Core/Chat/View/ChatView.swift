//
//  ChatView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/04/2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    var body: some View {
        VStack {
            ScrollView{
                VStack {
                    CircularProfileImageView(user: user, size: .large)
                    VStack(spacing: 4) {
                        if let fullname = user.fullname {
                            Text(fullname)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        Text("Message")
                    }
                }
                
                ForEach(viewModel.messages) {message in
                    ChatMessageCell(message: message)
                }
            }
            Spacer()
            
            ZStack(alignment: .trailing){
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 50)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button{
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView(user: User.MOCK_USER[0])
}
