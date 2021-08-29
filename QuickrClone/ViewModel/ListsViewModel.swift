//
//  ListsViewModel.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 26/08/21.
//

import Foundation
import Firebase

class ListsViewModel: ObservableObject{
    
    @Published var list: ListModel = ListModel(id:UUID().uuidString,name: "", category: "",sender: "",description: "",imgUrl: "")
    private var db = Firestore.firestore()
    var a = AddItem()
     
    func addData(list: ListModel){
        do{
          let _ = try db.collection("Listing").addDocument(from: list)
        }
        catch{
            print(error)
        }
    }

    func save(){
        addData(list: list)
    }
}
