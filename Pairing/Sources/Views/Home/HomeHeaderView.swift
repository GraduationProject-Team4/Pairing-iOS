//
//  HomeHeaderView.swift
//  Pairing
//
//  Created by 서은수 on 2023/07/27.
//

import SwiftUI

// MARK: - 홈 화면의 헤더 뷰

struct HomeHeaderView: View {
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image("PairingLogo")
                .resizable()
                .frame(width: 50, height: 60)
                .background(
                    Circle()
                        .fill(.white.opacity(0.9))
                        .frame(width: 96, height: 96)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Welcome to Pairing!")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 24))
                    .foregroundColor(.white)
                Text("Pairing은 청각장애인의 생활을 돕기 위해 제작된 앱입니다.\nPairing을 이용해 생활 속의 어려움들을 극복해보세요! 👀")
                    .font(.custom("AppleSDGothicNeo-Medium", size: 10))
                    .foregroundColor(Color("Blue00"))
            } //: VStack
            .offset(x: 23, y: 0)
            Spacer()
        } //: HStack
        .padding(.top, 90)
        .padding(.leading, 29)
        .padding(.bottom, 20)
    }
}

// MARK: - Preview

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
