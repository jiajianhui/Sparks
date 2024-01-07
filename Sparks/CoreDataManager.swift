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
    private let container: NSPersistentContainer
    
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
        container = NSPersistentContainer(name: "SparksDataModel") //创建容器，名称必须与模型名称一致
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
    func delete(_ spark: Spark) {
        viewContext.delete(spark)
        try? self.viewContext.save()
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
