//
//  ListView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import SwiftUI

struct ListView: View {
    
    var coreDataManager = CoreDataManager.shared
    
    //从数据库拿到数据
    @FetchRequest(fetchRequest: Spark.all()) var sparks
    
    @State var selectedSpark: Spark?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sparks) { spark in
                    ListRowView(spark: spark)
                        .swipeActions {
                            Button(role: .destructive) {
                                coreDataManager.delete(spark)
                            } label: {
                                Text("删除")
                            }
                            
                            Button {
                                coreDataManager.collecred(spark)
                            } label: {
                                Text(spark.collected ? "取消收藏" : "收藏")
                            }
                            .tint(.orange)

                        }
                        .onTapGesture {
                            selectedSpark = spark
                        }
                }
            }
            .navigationTitle("列表")
            .toolbar {
                ToolbarItem {
                    Button {
                        selectedSpark = Spark.empty()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(item: $selectedSpark) {
                selectedSpark =  nil
            } content: { spark in
                AddAndEditSheetView(vm: .init(coreDataManager: coreDataManager, spark: spark))
            }

        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
