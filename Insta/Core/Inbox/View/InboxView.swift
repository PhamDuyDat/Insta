//
//  InboxView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/04/2024.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @State private var selectedUser: User?
    @State private var Showchat = false
    @StateObject var viewModel = InboxViewModel()
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ActiveNowView()
                
                List {
                    ForEach(viewModel.recentMessages) { mesage in
                        InboxRowView(message: mesage)
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .onChange(of: selectedUser, perform: { Newvalue in
                Showchat = Newvalue != nil
            })
           
            .navigationDestination(isPresented: $Showchat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageNew(selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        CircularProfileImageView(user: user, size: .xSmall)
                            
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        selectedUser = nil
//                        print(user)
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
