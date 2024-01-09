//
//  NoListView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/7.
//

import SwiftUI

enum EmptyView {
    case all, star
}

struct NoListView: View {
    
    var emptyType: EmptyView = .all
    
    var body: some View {
        
        ScrollView {
            switch emptyType {
                case .all:
                emptyView
                case .star:
                emptyStarView
            }
        }
    }
}

struct NoListView_Previews: PreviewProvider {
    static var previews: some View {
        NoListView()
    }
}

extension NoListView {
    
    //列表页空视图
    var emptyView: some View {
        VStack(spacing: 8) {
            Text("暂无灵感")
                .font(.title.bold())
            Text("点击上面的“+”按钮来添加")
        }
        .frame(maxWidth: .infinity)
        .offset(x: 0, y: 200)
    }
    
    //收藏页空视图
    var emptyStarView: some View {
        VStack(spacing: 8) {
            Text("还没有收藏的灵感")
                .font(.title.bold())
//                    Text("滑动条目快速收藏")
        }
        .frame(maxWidth: .infinity)
        .offset(x: 0, y: 220)
    }
    
    
}
