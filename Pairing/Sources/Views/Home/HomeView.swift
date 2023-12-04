//
//  HomeView.swift
//  Pairing
//
//  Created by 서은수 on 2023/07/27.
//

import SwiftUI

// MARK: - 홈 화면

struct HomeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    // 커스텀한 Back button
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // 이전 화면으로 돌아가기
        }) {
            Image(systemName: "chevron.backward") // 뒤로가기 아이콘
                .foregroundColor(.black)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - Header
                    HomeHeaderView()
                    
                    VStack(alignment: .center, spacing: 26) {
                        // MARK: - Function Views
                        FunctionView(isScript: false, exampleImage: "EnvironmentExPic", functionName: "현재 환경 분석", description: "배경음을 녹음해 어떤 소리가 들리고 있는지 알아봅시다.\n기준 데시벨을 설정해준다면 큰 소리가 났을 때도 알려주니 문제없죠.")
                            .shadow(color: Color("EnvironmentExBack"), radius: 5, x: 0, y: 4)
                        FunctionView(isScript: true, exampleImage: "ScriptExPic", functionName: "실시간 대화 분석", description: "여러 명과 동시에 대화해야 할 때도 걱정하지 마세요. 실시간 대화 대본과 인공지능이 제공해주는 키워드가 있답니다.")
                            .shadow(color: Color("ScriptExBack"), radius: 5, x: 0, y: 4)
                    } //: VStack
                    .padding(.top, 30)
                } //: VStack
            } //: Scroll
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .navigationBarItems(leading: backButton) // 커스텀 Back Button 추가
        .foregroundColor(Color("HomeBack"))
    }
}

// MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
