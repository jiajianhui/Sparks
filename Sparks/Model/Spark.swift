//
//  Spark.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import Foundation
import CoreData

//自己创建模型管理数据，这里的名称最好与Entity的名称一致
class Spark: NSManagedObject, Identifiable {
    
    @NSManaged var title: String
    @NSManaged var content: String
    @NSManaged var timeStamp: Date
    @NSManaged var collected: Bool
    @NSManaged var image: Data?
    
    //添加默认值
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(Date(), forKey: "timeStamp")
        setPrimitiveValue(false, forKey: "collected")
    }
    
    //空Spark
    static func empty(context: NSManagedObjectContext = CoreDataManager.shared.newContext) -> Spark {
        Spark(context: context)
    }
    
    //验证输入是否有效
    var isVaild: Bool {
        //trimmingCharacters会去除字符串开头和结尾的空格和换行符
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}

extension Spark {
    
    //查询CoreData
    private static var sparksFetchRequest: NSFetchRequest<Spark> {
        NSFetchRequest(entityName: "Spark")
    }
    
    //对返回的结果排序
    static func all() -> NSFetchRequest<Spark> {
        let request: NSFetchRequest<Spark> = sparksFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Spark.timeStamp, ascending: true)
        ]
        
        return request
    }
    
    //搜索、筛选
    static func filter(with config: SearchConfig) -> NSPredicate {
        
        switch config.filter {
        case .all:
            //全部——如果搜索输入为空（包括空格、换行），返回全部，否则返回对应搜索
            return config.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", config.query)
        case .star:
            //收藏——如果搜索输入为空（包括空格、换行），返回所有收藏，否则返回对应搜索的收藏
            return config.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? NSPredicate(format: "collected == %@", NSNumber(value: true)) : NSPredicate(format: "title CONTAINS[cd] %@ AND collected == %@", config.query, NSNumber(value: true))
        }
        
    }
}




