//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Brandon Williams on 2/18/25.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
