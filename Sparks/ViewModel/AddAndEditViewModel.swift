//
//  AddAndEditViewModel.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import Foundation
import CoreData
import SwiftUI
import PhotosUI

//这个ViewModel的目的是，创建新的环境（在主视图之外），来新增和编辑Spark，然后将这些更改提交给CoreData，这样不影响主视图的环境
class AddAndEditViewModel: ObservableObject {
    
    @Published var spark: Spark
    
    private let context: NSManagedObjectContext
    private let coreDataManager: CoreDataManager
    
    var isNew: Bool  //判断是否为新数据
    
    init(coreDataManager: CoreDataManager, spark: Spark? = nil) {
        self.context = coreDataManager.newContext //新的上下文
        self.coreDataManager = coreDataManager
        
        //判断是否存在该项目
        if let spark,
           let existingSpark = coreDataManager.exisits(spark,
                                                       in: context) {
            self.spark = existingSpark
            self.isNew = false
        } else {
            self.spark = Spark(context: self.context) //发布的spark在新的上下文中
            self.isNew = true
        }
       
    }
    
    //保存更改
    func save() {
        if context.hasChanges { //如果上下文有更改，就执行保存，性能更好
            try? context.save()
        }
    }
    
    
    //页面展示的图片
    @Published var selectedImage: UIImage? = nil
    
    //当选择图片有变化时，执行setImage函数
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
}


extension AddAndEditViewModel {
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                //1、将选择的图片转换为二进制数据
                let data = try await selection.loadTransferable(type: Data.self)
                
                //2、将二进制数据转为UIImage数据
                guard let data,
                      let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                
                //3、将数据保存至CoreData
                spark.image = data
                
                DispatchQueue.main.async {
                    //4、将数据赋值
                    self.selectedImage = uiImage
                }
                
            } catch {
                print(error)
            }
        }
    }
}


