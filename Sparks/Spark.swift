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
    @NSManaged var timeStamp: String
    @NSManaged var collected: Bool
    @NSManaged var image: Data?
    
    //添加默认值
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(displayDate(Date.now), forKey: "timeStamp")
        setPrimitiveValue(false, forKey: "collected")
    }
    
    //空Spark
    static func empty(context: NSManagedObjectContext = CoreDataManager.shared.newContext) -> Spark {
        Spark(context: context)
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
}




