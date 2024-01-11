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
    
    //检查输入是否合法，借助alert提示
    @State var hasError = false
    
    //键盘相关
    enum TextFieldName {
        case textField1
    }
    @FocusState var focused: TextFieldName?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("灵感名称")
                            .smallTitleStyle()
                        TextField("请输入灵感名称", text: $vm.spark.title)
                            .textFieldStyle()
                            .focused($focused, equals: .textField1)
                            .submitLabel(.done)  //自定义键盘提交按钮的文案
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("灵感详情")
                            .smallTitleStyle()
                        TextEditor(text: $vm.spark.content)
                            .textEditorStyle()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("添加图片")
                            .smallTitleStyle()

                        PhotosPicker(selection: $vm.imageSelection, matching: .images) {
                            if vm.spark.image != nil {
                                if let data = UIImage(data: vm.spark.image!) {
                                    Image(uiImage: data)
                                        .imageDisplayStyle()
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
                                    .noImageDisplayStyle()
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                //自动唤起键盘
                .onAppear {
                    focused = .textField1
                }
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
                        validSave()
                    } label: {
                        Text(vm.isNew ? "添加" : "确定")
                            .fontWeight(.medium)
                    }

                }
            }
            
            .alert(isPresented: $hasError) {
                Alert(title: Text("灵感名称不能为空🙏"), dismissButton: .default(Text("好的")))
            }
            
        }
    }
}

//struct AddAndEditSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddAndEditSheetView(vm: .init(coreDataManager: .shared))
//    }
//}


//验证保存
extension AddAndEditSheetView {
    func validSave() {
        if vm.spark.isVaild {
            vm.save()
            dismiss()
        } else {
            hasError = true
        }
    }
}


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

struct NoImageDisplayStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .medium))
            .foregroundColor(Color(uiColor: .systemGray3))
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(Color("inputColor"))
            .cornerRadius(10)
    }
}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("inputColor"))
            .cornerRadius(10)
    }
}

struct TextEditorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .frame(minHeight: 200)
            .padding()
            .background(Color("inputColor"))
            .cornerRadius(10)
    }
}

//扩展View来创建新函数，方便实用modifier，更符合使用习惯
extension View {
    func smallTitleStyle() -> some View {
        self.modifier(SmallTitleStyle())
    }
    
    func noImageDisplayStyle() -> some View {
        self.modifier(NoImageDisplayStyle())
    }
    
    func textFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
    
    func textEditorStyle() -> some View {
        self.modifier(TextEditorStyle())
    }
}


//图片样式组件，resizable()仅适用于image，不能用来扩展通用视图，所以要单独拿出来
extension Image {
    func imageDisplayStyle() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(minHeight: 300)
            .frame(width: UIScreen.main.bounds.width - 32)  //必须是明确的数值，否则图片可能溢出
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
