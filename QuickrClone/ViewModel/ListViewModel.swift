//
//  ListViewModel.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 25/08/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ListViewModel: ObservableObject {
    @Published var list = [ListModel]()
    private var db = Firestore.firestore()

    func fetchData(){
        db.collection("Listing").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No doc")
                return
            }
            self.list = documents.compactMap { (queryDocumentSnapshot) -> ListModel? in
                return try? queryDocumentSnapshot.data(as: ListModel.self)
            } 
        }
    }
    
}
