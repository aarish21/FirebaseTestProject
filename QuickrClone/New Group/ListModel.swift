//
//  ListModel.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 25/08/21.
//

import Foundation
import FirebaseFirestoreSwift

struct ListModel: Identifiable, Codable {
    @DocumentID var id = UUID().uuidString
    var name: String
    var category:String
    var sender: String
    var description:String
    var imgUrl: String
}
