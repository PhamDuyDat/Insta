//
//  NewMessageNew.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/04/2024.
//

import SwiftUI

struct NewMessageNew: View {
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageModel()
    @Binding var selectedUser: User?
    @Environment (\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView{
                TextField("To", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("CONTACTS")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(viewModel.user) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)
                            
                            if let fullname = user.fullname {
                                Text(fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                      selectedUser = user
                      dismiss()
               }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
        }
        }
    }
}

#Preview {
    NavigationStack {
       NewMessageNew(selectedUser: .constant(User.MOCK_USER[0]))
    }
}
