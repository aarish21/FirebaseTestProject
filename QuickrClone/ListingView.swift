//
//  ListingView.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 29/08/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import URLImage

struct ListingView: View {
    @ObservedObject private var viewModel = ListViewModel()
    @StateObject var Model = ListsViewModel()
    @Environment(\.managedObjectContext) var moc
    @State private var showAddScreen = false
    var body: some View {
        List{
            ForEach(viewModel.list){list in
                if Auth.auth().currentUser?.email == list.sender{
                    HStack{
                        Image(uiImage: list.imgUrl.load())
                            .resizable()
                            .frame(width: 90, height: 100)
                            .aspectRatio(contentMode: .fill)
                            .padding()
                        VStack(alignment: .leading){
                            Text(list.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(list.category)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(list.description)
                                .font(.caption)
                        }
                    }
                }
                
            }
            
        }
        .navigationBarTitle("Browse")
        .navigationBarItems(trailing:
                                Button(action: {showAddScreen.toggle()}, label: {
                                    Image(systemName: "plus")
                                }))
        .sheet(isPresented: $showAddScreen, content: {
                                    AddItem()
                                })
        .onAppear(){
            self.viewModel.fetchData()
             }
    }
    
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
