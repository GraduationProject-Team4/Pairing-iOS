//
//  EnvironmentAnalysis.swift
//  Pairing
//
//  Created by 서은수 on 2023/07/27.
//

import SwiftUI

// MARK: - 환경 분석 화면

struct EnvironmentAnalysis: View {
    
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
    
    var body: some View {
        Text("Environment Analysis")
            .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
            .navigationBarItems(leading: backButton) // 커스텀 Back Button 추가
    }
}

struct EnvironmentAnalysis_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentAnalysis()
    }
}
