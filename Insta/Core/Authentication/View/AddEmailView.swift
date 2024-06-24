//
//  AddEmailView.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 12/03/2024.
//

import SwiftUI

struct AddEmailView: View {
    // thoát khỏi màn hình
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Add your Email")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            Text("You'll use this email to sign in your account")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)

            NavigationLink {
                CreateUserNameView()
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
    AddEmailView()
}
