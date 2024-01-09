//
//  SettingSheetView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/8.
//

import SwiftUI

struct SettingSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var content: SheetContentModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(content.symbol)
                        .font(.system(size: 46))
                    Text(content.content1)
                    Text(content.content2)
                    if content.content3 != nil {
                        Text(content.content3!)
                    }
                }
                .lineSpacing(7)
                .padding(.horizontal, 16)
                .padding(.top, 4)
                    
            }
            .navigationTitle(content.title)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 38, height: 5)
                        .opacity(0.2)
                }
            }
        }
    }
}

struct SettingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SettingSheetView(content: SheetContentModel(title: "hello", symbol: "标题", content1: "第一行", content2: "第二行", content3: "第三行"))
    }
}
