//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by sjp on 2021/11/18.
//

import SwiftUI

@main
struct Landmarks_1App: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
