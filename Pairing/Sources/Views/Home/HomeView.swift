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
                ZStack {
                    Image("HomeBackground")
                        .resizable()
                        .scaledToFill()
                    
                    VStack(alignment: .leading, spacing: 50) {
                        // MARK: - Header
                        HomeHeaderView()
                        
                        VStack(alignment: .center, spacing: 20) {
                            // MARK: - Function Views
                            FunctionView(isScript: false, exampleImage: "EnvironmentExPic", functionName: "☕️ 현재 환경 분석하기", description: "현재 환경 배경음을 녹음해 현재 환경에서 어떤 소리가 들리고 있는지 표시해요.\n사용자가 설정한 특정 데시벨 이상을 인식할 경우 주의 알림이 울립니다.")
                            FunctionView(isScript: true, exampleImage: "ScriptExPic", functionName: "📄 실시간으로 대화 대본 제공받기", description: "여러 명과 대화할 경우에도 걱정 없어요!\nPairiing은 대화 내용을 추출해 실시간으로 화면에 띄워주고, 인공지능을 이용해 실시간 대화를 요약한 후 키워드를 제공합니다.")
                        } //: VStack
                    } //: VStack
                    .padding(.bottom, 35)
                } //: ZStack
            } //: Scroll
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .navigationBarItems(leading: backButton) // 커스텀 Back Button 추가
    }
}

// MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
