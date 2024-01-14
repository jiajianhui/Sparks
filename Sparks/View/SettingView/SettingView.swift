//
//  SettingView.swift
//  Sparks
//
//  Created by 贾建辉 on 2024/1/8.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    
    //各种sheet
    @State var showDesignSheet = false
    @State var showAboutMeSheet = false
    @State var showPrivacy = false
    
    //sheet数据源
    @ObservedObject var vm = SettingViewData()
    
    //与父级的isToggle相绑定
    @Binding var isToggle: Bool
    
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        showDesignSheet.toggle()
                    } label: {
                        SettingRowView(imageString: "pencil.and.ruler.fill", linkTitle: "设计初衷")
                    }
                    .sheet(isPresented: $showDesignSheet) {
                        SettingSheetView(content: vm.designSheetContent)
                    }

                    Button {
                        showAboutMeSheet.toggle()
                    } label: {
                        SettingRowView(imageString: "person.fill", linkTitle: "关于开发者")
                    }
                    .sheet(isPresented: $showAboutMeSheet) {
                        SettingSheetView(content: vm.aboutMeSheetContent)
                    }
                } header: {
                    Text("关于")
                }
                
                Section {
                    faceidToggle
                } footer: {
                    Text("开启后，打开App时会进行验证")
                }
                
                Section {
                    ShareLink(item: URL(string: "https://apps.apple.com/app/id6475958954")!) {
                        SettingRowView(imageString: "square.and.arrow.up.fill", linkTitle: "分享产品")
                    }

                    Button {
                        emailFeedBack()
                    } label: {
                        SettingRowView(imageString: "ellipsis.message.fill", linkTitle: "产品反馈")
                    }
                    
                    Button {
                        showPrivacy.toggle()
                    } label: {
                        SettingRowView(imageString: "hand.raised.slash.fill", linkTitle: "隐私政策")
                    }
                    .sheet(isPresented: $showPrivacy) {
                        SettingSheetView(content: vm.privacySheetContent)
                    }

                    Button {
                        star()
                    } label: {
                        SettingRowView(imageString: "hand.thumbsup.fill", linkTitle: "去评分")
                    }
                    
                } header: {
                    Text("产品")
                }
                footer: {
                    Text("当前版本 1.0")
                }

            }
            .navigationTitle("设置")
//            .navisty
        }
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isToggle: .constant(true))
    }
}


//相关函数
extension SettingView {
    //唤起邮件函数
    private func emailFeedBack() {
        //获取APP名称及版本、iOS版本
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String,
           let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let iOSVersion = UIDevice.current.systemVersion
            
            let subject = "\(appName)-\(appVersion);iOS-\(iOSVersion)" //注意不要有空格，若有，addingPercentEncoding来处理
            
            //发送电子邮件的 URL 格式应该以 mailto: 开头，然后跟着收件人的电子邮件地址。使用 ?subject= 添加主题内容
            let email = "mailto:jia15176168273@icloud.com?subject=\(subject)"
            
            if let emailURL = URL(string: email) {
                UIApplication.shared.open(emailURL)
            }
        }
    }
    
    //评分函数
    private func star() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
    }
    
    
    //验证开关
    var faceidToggle: some View {
        HStack {
            Toggle(isOn: $isToggle) {
                HStack {
                    Image(systemName: "key.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .opacity(0.3)
                    Text("开启面容ID验证")
                        .fontWeight(.medium)
                }
            }
            .tint(.blue)
            .padding(.vertical, 4)
        }
    }
    
}
