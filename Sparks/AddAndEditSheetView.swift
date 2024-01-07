//
//  AddAndEditSheetView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/6.
//

import SwiftUI
import PhotosUI

struct AddAndEditSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm: AddAndEditViewModel
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("主题名称")
                            .modifier(SmallTitleStyle())
                        TextField("请输入主题", text: $vm.spark.title)
                            .modifier(TextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("主题详情")
                            .modifier(SmallTitleStyle())
                        TextEditor(text: $vm.spark.content)
                            .modifier(TextEditorStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("添加图片")
                            .modifier(SmallTitleStyle())

                        HStack {
                            PhotosPicker(selection: $vm.imageSelection, matching: .images) {
                                if vm.spark.image != nil {
                                    if let data = UIImage(data: vm.spark.image!) {
                                        Image(uiImage: data)
                                            .resizable()
                                            .modifier(AddImageStyle())
                                            .overlay(alignment: .topTrailing) {
                                                Button {
                                                    vm.spark.image = nil
                                                    vm.imageSelection = nil
                                                } label: {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .offset(x: 6, y: -6)
                                                        .symbolRenderingMode(.palette)
                                                        .foregroundStyle(.white, .red)
                                                }
                                            }
                                    }
                                } else {
                                    Image(systemName: "plus")
                                        .modifier(AddImageStyle())
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)
            }
            .background {
                Color(uiColor: .systemGray6).ignoresSafeArea()
            }
            
            .navigationTitle(vm.isNew ? "添加灵感" : "编辑灵感")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.save()
                        dismiss()
                    } label: {
                        Text(vm.isNew ? "添加" : "完成")
                            .fontWeight(.medium)
                    }

                }
            }
            
        }
    }
}

//struct AddAndEditSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddAndEditSheetView(vm: .init(coreDataManager: .shared))
//    }
//}


//MARK: - 样式组件
//将样式组件化
struct SmallTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.horizontal, 8)
    }
}

struct AddImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .medium))
            .foregroundColor(Color(uiColor: .systemGray3))
            .frame(width: 100, height: 100)
            .background(Color.white)
            .cornerRadius(16)
    }
}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                Color.white.cornerRadius(16)
            }
    }
}

struct TextEditorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .frame(minHeight: 300)
            .padding()
            .background (
                Color.white.cornerRadius(16)
            )
    }
}
