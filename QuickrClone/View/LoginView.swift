//
//  LoginView.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 25/08/21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var log = false
    @State private var alertToggle = false
    var body: some View {
        
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
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                        .padding()
                        .onTapGesture {
                                login()
                        }
                }.alert(isPresented: $alertToggle, content: {
                    Alert(title: Text("Incorrect Details"), message: Text("Input Correct Id and Password"), dismissButton: .default(Text("ok")))
                })
                Spacer()
            }
            .padding()
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.log = false
                self.alertToggle = true
            }
            else{
                print("success")
                self.log = true
                self.alertToggle = false
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
