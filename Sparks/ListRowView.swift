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
                        .cornerRadius(10)
                }
            }
            
            //日期及收藏
            HStack(spacing: 4) {
                Image(systemName: "calendar")
                Text(spark.timeStamp)
                
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
}

//struct ListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRowView()
//    }
//}
