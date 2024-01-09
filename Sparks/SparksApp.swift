//
//  SparksApp.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import SwiftUI
import LocalAuthentication

@main
struct SparksApp: App {
    
    @AppStorage("isToggle") var isToggle = false //将变量存储起来
    @State var locked = true
    
    @State private var selectedIndex: Int = 0
    
    var body: some Scene {
        WindowGroup {
            
            Group {
                if locked && isToggle {
                    LockedView(authorize: authorize)
                } else {
                    TabView(selection: $selectedIndex) {
                        ListView()
                            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
                            .tabItem {
                                Image(systemName: "bubbles.and.sparkles")
                                Text("灵感")
                            }
                            .tag(0)
                        
                        SettingView(isToggle: $isToggle)
                            .tabItem {
                                Image(systemName: "gear")
                                Text("设置")
                            }
                            .tag(1)
                    }
                    .onChange(of: selectedIndex) { _ in
                        UIImpactFeedbackGenerator.impact(style: .medium)
                    }
                }
            }
            .onAppear {
                if isToggle {
                    authorize()
                }
            }
            .onChange(of: isToggle) { newValue in
                if newValue {
                    authorize()
                }
            }
            
        }
    }
}


extension SparksApp {
    func authorize() {
        let context = LAContext()  //开发者与框架的中介
        var error: NSError?  //框架要求的错误类型
        
        //1、判断设备是否支持FaceID或TouchID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 2、识别函数
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "解锁应用") { result, _ in
                if result {
                    locked = false
                }
            }
        }
        
    }
}
