//
//  CreateUserNameView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 12/03/2024.
//

import SwiftUI

struct CreateUserNameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    var body: some View {
        VStack(spacing: 12) {
            Text("Create userName")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            Text("Pick a username for your new account. You can always change it later.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Username", text: $viewModel.userName)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())

            NavigationLink {
                CreatePasswordView()
                .navigationBarBackButtonHidden(true)
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                // thoát khỏi màn hình
                    .onTapGesture {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CreateUserNameView()
}
