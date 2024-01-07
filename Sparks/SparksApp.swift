//
//  SparksApp.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import SwiftUI

@main
struct SparksApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
