//
//  SettingViewData.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/8.
//

import Foundation

struct SheetContentModel {
    var title: String
    var symbol: String
    var content1: String
    var content2: String
    var content3: String?
    
}

class SettingViewData: ObservableObject {
    
    @Published var designSheetContent = SheetContentModel(
        title: "设计初衷",
        symbol: "🫧",
        content1: "头脑中的灵感转瞬即逝，就像泡泡。",
        content2: "我想做一款简单的App，记录这些灵感，让灵感持续发生。"
    )
    
    @Published var aboutMeSheetContent = SheetContentModel(
        title: "关于开发者",
        symbol: "👋",
        content1: "创造深植于内心，上架一款APP是我一直以来的心愿。",
        content2: "进入新的领域，学习新的知识，从来都是让我无比兴奋的事情；这一次我使用 SwiftUI 来完成这一款APP，过程充满乐趣与挑战，在经历过无数次 Build Succeeded 后，终于完成了这款APP。",
        content3: "这次只是一个开始，未来我会带来更多好玩的产品！"
    )
    
    @Published var privacySheetContent = SheetContentModel(
        title: "隐私政策",
        symbol: "🙅",
        content1: "隐私大于一切！！！",
        content2: "我们非常在意您的隐私，绝对不会上传您的任何数据，所有数据均在设备端离线运行。"
    )
}
