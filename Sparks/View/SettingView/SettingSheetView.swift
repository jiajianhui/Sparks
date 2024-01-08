//
//  SettingSheetView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/8.
//

import SwiftUI

struct SettingSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var title: String
    var symbol: String
    var content1: String
    var content2: String
    var content3: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(symbol)
                        .font(.system(size: 46))
                    Text(content1)
                    Text(content2)
                    if content3 != nil {
                        Text(content3!)
                    }
                }
                .lineSpacing(7)
                .padding(.horizontal, 16)
                .padding(.top, 4)
                    
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    XmarkView(dismiss: _dismiss)
                }
            }
        }
    }
}

struct SettingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SettingSheetView(title: "hello", symbol: "👋", content1: "第一行", content2: "第二行", content3: "第三行")
    }
}
