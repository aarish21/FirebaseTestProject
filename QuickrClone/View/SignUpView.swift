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
    @State private var alertToggle = false
    @State private var log = false
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .center)
                    .foregroundColor(.purple)
                Spacer()
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
                
                NavigationLink(destination: ListingView(), isActive: $log){
                    
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                        .padding()
                        .onTapGesture {
                            signUP()
                        }
                }
                
                .alert(isPresented: $alertToggle, content: {
                    Alert(title: Text("Incorrect Details"), message: Text("Input Id and Password"), dismissButton: .default(Text("ok")))
                })
                Spacer()
            }
            .padding()
        }
    }
    func signUP(){
         Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
             if error != nil {
                 print(error?.localizedDescription ?? "")
                self.alertToggle = true
                self.log = false
             }
             else{
                 print("success")
                self.alertToggle = false
                self.log = true
             }
         }
     }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
