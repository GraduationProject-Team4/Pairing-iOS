//
//  FunctionView.swift
//  Pairing
//
//  Created by 서은수 on 2023/07/27.
//

import SwiftUI

// MARK: - 앱의 기능을 소개하고 안내하는 기능 뷰

struct FunctionView: View {
    
    // MARK: - Properties
    
    var isScript: Bool
    @State private var showScript: Bool = false
    @State private var showEnvironment: Bool = false
    
    var exampleImage: String
    var functionName: String
    var description: String
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // 컨테이너 뷰
            RoundedRectangle(cornerRadius: 16)
                .fill(.white.opacity(0.9))
                .frame(width: 365, height: 320)
            
            VStack(alignment: .center, spacing: 10) {
                Image(exampleImage)
                    .resizable()
                    .frame(width: 340, height: 175)
                    .padding(.top, -10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {
                        isScript ? showScript.toggle() : showEnvironment.toggle()
                    }, label: {
                        // 대본 제공받기 클릭 시
                        if isScript {
                            // 실시간 대본 기능으로 이동
                            NavigationLink(destination: PreRecordingView(), isActive: $showScript) {
                                FunctionTitleView(functionName: functionName)
                            }
                        } else {
                            // 환경 분석 기능으로 이동
                            NavigationLink(destination: EnvRecordingInfoView(beforeEnvReport: true), isActive: $showEnvironment) {
                                FunctionTitleView(functionName: functionName)
                            }
                        }
                    })
                    
                    Text(description)
                        .frame(width: 346)
                        .font(.custom("AppleSDGothicNeo-Light", size: 11))
                        .foregroundColor(Color("Gray04"))
                        .frame(width: 346, alignment: .leading)
                } //: VStack
            } //: VStack
        } //: ZStack
    }
}

// MARK: - FunctionTitleView

struct FunctionTitleView: View {
    var functionName: String
    var body: some View {
        Text("\(functionName) >")
            .font(.custom("AppleSDGothicNeo-Bold", size: 20))
            .padding(.top, 5)
            .foregroundColor(.black)
    }
}

// MARK: - Preview

struct FunctionView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionView(isScript: false, exampleImage: "EnvironmentExPic", functionName: "PREVIEW", description: "PREVIEW")
    }
}
