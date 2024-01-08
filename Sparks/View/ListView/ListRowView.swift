//
//  ListRowView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import SwiftUI

struct ListRowView: View {
    
    @ObservedObject var spark: Spark
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(spark.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(spark.content)
                        .font(.system(size: 14))
                }
                .lineLimit(1)
                
                Spacer()
                if spark.image != nil {
                    let uiImage = UIImage(data: spark.image!)
                    Image(uiImage: uiImage!)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(6)
                }
            }
            .frame(minHeight: 66) //有图片和没图片的项目高度保持一致；只有文字时，swipeAction按钮只显示symbol
            
            //日期及收藏
            HStack(spacing: 4) {
                Image(systemName: "calendar")
                Text(displayDate(spark.timeStamp))
                
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                    .opacity(spark.collected ? 1 : 0)
            }
            .font(.system(size: 12))
            .foregroundColor(.gray)
            
        }
        .padding(2)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            Color.white.opacity(0.0001)  //方便点击
        }
    }
    
    //时间格式化
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "zh_Hans")
        formatter.setLocalizedDateFormatFromTemplate("HH:mm MM-dd")
        
        return formatter
    }()
    
    //将Date转换为String
    func displayDate(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}

//struct ListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRowView()
//    }
//}
