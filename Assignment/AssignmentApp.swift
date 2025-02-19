//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

@main
struct AssignmentApp: App {
    
    init() {
        URLCache.shared = URLCache.init(memoryCapacity: 20*1024*1024, diskCapacity: 100*1024*1024)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
