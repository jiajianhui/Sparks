//
//  LockedView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/8.
//

import SwiftUI

struct LockedView: View {
    var authorize: () -> ()  //函数类型，无参数和返回值
    
    var body: some View {
        Button {
            authorize()
        } label: {
            VStack {
                Image(systemName: "faceid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 4)
                Text("点击解锁")
            }
            .foregroundColor(.primary.opacity(0.4))
        }
    }
}

struct LockedView_Previews: PreviewProvider {
    static var previews: some View {
        LockedView(authorize: test)
    }
    
    static func test() {
        print("hello")
    }
}
