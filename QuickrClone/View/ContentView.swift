//
//  ContentView.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 24/08/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing:10){
                        VStack(alignment: .leading,spacing: 4){
                            Spacer()
                            HStack {
                                Spacer()
                                Image("Illustration 1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                                Spacer()
                            }
                            
                        }
                        .frame(width: 320, height: 480, alignment: .center)
                        .padding()
                        .background(Color("Background 5"))
                        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                        .shadow(color: Color.blue.opacity(0.3), radius: 22, x: 0, y: 10 )
                        
                        VStack(spacing:10){
                            
                            NavigationLink(destination:LoginView()){
                                Text("Sign In")
                                        .foregroundColor(.white)
                                .frame(width: 300, height: 50, alignment: .center)
                                .background(Color.purple)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                                    
                            }
                            NavigationLink(destination:SignUpView()){
                                Text("Sign Up")
                                        
                                    .foregroundColor(.white)
                                .frame(width: 300, height: 50, alignment: .center)
                                .background(Color.purple)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                                   
                            }
                        }
                        
                }.navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
