//
//  EnvironmentRecordingView.swift
//  Pairing
//
//  Created by 서은수 on 2023/08/03.
//

import SwiftUI

// MARK: - 환경 분석 녹음 안내 화면

struct EnvRecordingInfoView: View {
    
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
        NavigationView {
            ZStack {
                Image("EnvironmentBackground2")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 40) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 120, height: 120)
                            
                            Image("EnvAnalysisSymbol")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 55)
                        } // ZStack
                        
                        Text("환경 분석을 위해\n주변 소리를 녹음해주세요!")
                            .lineLimit(nil)
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color("Purple04"))
                        
                        Text("10초 동안 주변 소리를 녹음해\n현재 환경을 분석한 레포트를 제공해 드릴게요.")
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Purple01"))
                        
                        NavigationLink(destination: EnvRecordingView()) {
                            Text("소리 녹음 시작")
                                .font(.system(size: 15, weight: .semibold))
                                .tint(.white)
                                .frame(width: 366, height: 56)
                                .background(Color("Purple03"))
                                .cornerRadius(8)
                                .padding(.top)
                        }
                        
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("녹음을 중지할래요")
                                .font(.system(size: 15, weight: .semibold))
                                .tint(Color("Purple02"))
                        }
                    } // VStack
                    .padding(.horizontal)
                    .padding(.top, 55)
                    .padding(.bottom, 120)
                    .background(Color("Gray01"))
                    .cornerRadius(35)
                } // VStack
                .frame(height: 700)
                .offset(y: 100)
            } //: ZStack
        } // Navi
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .navigationBarItems(leading: backButton) // 커스텀 Back Button 추가
    } // body
}

struct EnvRecordingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EnvRecordingInfoView()
    }
}
