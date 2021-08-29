//
//  SignUpView.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 25/08/21.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing: 10){
            TextField("email", text: $email)
                 .autocapitalization(.none)
                 .disableAutocorrection(true)
                 .font(Font.system(size: 30, design: .default))
                .textFieldStyle( RoundedBorderTextFieldStyle() )
                 
                 
             SecureField("password", text: $password)
                 .autocapitalization(.none)
                 .disableAutocorrection(true)
                 .font(Font.system(size: 30, design: .default))
                 .textFieldStyle( RoundedBorderTextFieldStyle() )
                 
            Button(action: {signUP()}, label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .font(.title2)
            })
            .frame(width: 300, height: 50, alignment: .center)
            .background(Color.purple)
            .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            .padding()
                
        }
        .padding()
    }
    func signUP(){
         Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
             if error != nil {
                 print(error?.localizedDescription ?? "")
             }
             else{
                 print("success")
             }
         }
     }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
