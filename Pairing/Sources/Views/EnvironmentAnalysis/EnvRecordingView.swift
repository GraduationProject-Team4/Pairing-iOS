//
//  EnvironmentRecordingView.swift
//  Pairing
//
//  Created by 서은수 on 2023/08/03.
//

import SwiftUI

// MARK: - 환경 분석 녹음 중 화면

struct EnvRecordingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("EnvironmentBackground2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                VStack {
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 100)
                        
                        Image("EnvAnalysisSymbol")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55)
                    } // ZStack
                    Text("주변 소리를\n듣고 있습니다...")
                        .padding(.top, 30)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                    Text("수집되는 소리는 환경 분석에만 사용될 뿐, 저장되지 않아요!")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("녹음을 중지할래요")
                    }
                    .padding(.top, 40)
                    .foregroundColor(.white)
                    .opacity(0.6)
                    .bold()
                } // VStack
            } // ZStack
        } // Navi
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
    }
}


struct EnvRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        EnvRecordingView()
    }
}
