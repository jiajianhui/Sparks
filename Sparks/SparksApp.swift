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
            TabView {
                ListView()
                    .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
                    .tabItem {
                        Image(systemName: "bubbles.and.sparkles")
                        Text("灵感")
                    }
                
                SettingView(isToggle: .constant(false))
                    .tabItem {
                        Image(systemName: "gear")
                        Text("设置")
                    }
            }
            
        }
    }
}
