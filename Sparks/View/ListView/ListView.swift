//
//  ListView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import SwiftUI

//搜索、筛选
struct SearchConfig: Equatable {
    
    enum Filter {
        case all, star
    }
    
    var query: String = ""
    var filter: Filter = .all
}

struct ListView: View {
    
    var coreDataManager = CoreDataManager.shared
    
    //从数据库拿到数据
    @FetchRequest(fetchRequest: Spark.all()) var sparks
    
    //是否点击项目
    @State var selectedSpark: Spark?
    
    //筛选配置项
    @State var searchConfig: SearchConfig = .init()
    
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                if !sparks.isEmpty {
                    List {
                        ForEach(sparks) { spark in
                            ListRowView(spark: spark)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        coreDataManager.delete(spark, in: coreDataManager.newContext)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                        Text("删除")
                                    }
                                    
                                    Button {
                                        coreDataManager.collecred(spark)
                                    } label: {
                                        Image(systemName: "star.fill")
                                        Text(spark.collected ? "取消收藏" : "收藏")
                                    }
                                    .tint(.orange)

                                }
                                .onTapGesture {
                                    selectedSpark = spark
                                }
                        }
                    }
                } else if searchConfig.filter == .star && sparks.filter ({ $0.collected }).isEmpty {
                    NoListView(emptyType: .star)
                } else {
                    NoListView(emptyType: .all)
                }
            }
            
            .searchable(text: $searchConfig.query, prompt: Text("搜索"))
            
            .navigationTitle("灵感")
            .toolbar {
                ToolbarItem {
                    Button {
                        UIImpactFeedbackGenerator.impact(style: .rigid)
                        selectedSpark = Spark.empty()  //将空的Spark赋值给selectedSpark，来进行添加；empty()在新的上下文中，所以，即使点击取消，也不会添加空的Spark
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Picker("picker", selection: $searchConfig.filter) {
                        Text("全部").tag(SearchConfig.Filter.all)
                        Text("收藏").tag(SearchConfig.Filter.star)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 160)
                }
            }
            .sheet(item: $selectedSpark) {
                selectedSpark =  nil
            } content: { spark in
                AddAndEditSheetView(vm: .init(coreDataManager: coreDataManager, spark: spark))
            }

            .onChange(of: searchConfig) { newConfig in
                sparks.nsPredicate = Spark.filter(with: newConfig)
            }
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
