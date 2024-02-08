//
//  CoreDataManager.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import Foundation
import CoreData
import SwiftUI

//主要负责在CoreData中加载和管理数据
class CoreDataManager {
    
    //自身初始化
    static let shared = CoreDataManager()
    
    //创建容器，支持本地和网络存储
    private let container: NSPersistentCloudKitContainer
    
    //创建上下文
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    //创建新的上下文，方便后面的编辑和添加
    var newContext: NSManagedObjectContext {
        container.newBackgroundContext()
    }
    
    
    //启动方法
    init() {
        container = NSPersistentCloudKitContainer(name: "SparksDataModel") //创建容器，名称必须与模型名称一致
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("...")
        }
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)  //启用历史记录跟踪。这是为了支持 Core Data 的历史记录追踪功能。
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy  //设置合并策略
        container.viewContext.automaticallyMergesChangesFromParent = true //viewContext变化时，自动保存
        container.loadPersistentStores { _, error in //加载CoreData数据
            if let error {
                fatalError("无法加载数据 \(error)")
            }
        }
    }
    
}


//数据的管理
extension CoreDataManager {
    func delete(_ spark: Spark, in context: NSManagedObjectContext) {  //在新的上下文中进行删除
        if let existingContact = exisits(spark, in: context) {
            context.delete(existingContact)
            try? context.save()
        }
    }
    
    func collecred(_ spark: Spark) {
        spark.collected.toggle()
        try? self.viewContext.save()
    }
}

//
extension CoreDataManager {
    func exisits(_ spark: Spark,
                 in context: NSManagedObjectContext ) -> Spark? {
        try? context.existingObject(with: spark.objectID) as? Spark
    }
}
