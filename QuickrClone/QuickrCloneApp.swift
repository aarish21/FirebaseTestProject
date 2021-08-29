//
//  QuickrCloneApp.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 24/08/21.
//

import SwiftUI
import Firebase


@main
struct QuickrCloneApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
