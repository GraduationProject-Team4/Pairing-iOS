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
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Pairing")
                        .foregroundColor(.black)
                        .font(.title1)
                    Text("당신의 생활을 돕기 위한 2가지 기능")
                        .foregroundColor(Color("Gray04"))
                        .font(.paragraph5)
                }
                
                Spacer()
                
                Image("PairingLogo")
                    .resizable()
                    .frame(width: 50, height: 60)
                    .padding(.trailing, 30)
            } //: HStack
            .padding(.top, 90)
            .padding(.leading, 29)
            .padding(.bottom, 20)
            
            Divider()
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }
}

// MARK: - Preview

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
