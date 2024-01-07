//
//  NoListView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/7.
//

import SwiftUI

struct NoListView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("🧐还没有灵感啊")
                .font(.title.bold())
            Text("点击上面的 + 按钮来快速添加☝️")
        }
    }
}

struct NoListView_Previews: PreviewProvider {
    static var previews: some View {
        NoListView()
    }
}
