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
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(content.content1)
                    Text(content.content2)
                    if content.content3 != nil {
                        Text(content.content3!)
                    }
                }
                .lineSpacing(3)
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
        SettingSheetView(content: SettingViewData().aboutMeSheetContent)
    }
}
