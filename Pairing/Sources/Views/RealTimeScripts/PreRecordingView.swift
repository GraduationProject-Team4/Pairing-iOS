//
//  RecordingView.swift
//  Pairing
//
//  Created by YOUJIM on 2023/07/24.
//

import SwiftUI

struct PreRecordingView: View {
    
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
                Image("RealTimeScriptBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 30) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 100)
                            
                            Image("RealTimeScriptSymbol")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 55)
                        } // ZStack
                        
                        Text("대화 녹음을 시작합니다 👀")
                            .font(.title1)
                            .foregroundColor(Color("Yellow06"))
                        
                        Text("준비되셨나요?\n대화가 가장 잘 들리는 위치에 휴대폰을 위치해주세요.\n대화를 보다가 키워드 요약이 필요하다면\n대화를 요약해주세요 버튼을 클릭해주세요.\n대화를 끝마치고 싶다면\n녹음을 중지할래요 버튼을 클릭해주세요.\n\n수집되는 녹음 정보는 대화가 끝난 후 곧바로 폐기돼요!")
                            .multilineTextAlignment(.center)
                            .font(.paragraph3)
                            .foregroundColor(Color("Gray03"))
                        
                        NavigationLink(destination: RealTimeRecordingView()) {
                            Text("유의사항을 확인했어요")
                                .font(.paragraph1)
                                .padding(.horizontal, 90)
                                .padding(.vertical, 15)
                                .background(Color("Yellow05"))
                                .foregroundColor(Color.white)
                                .cornerRadius(8)
                        }
                        .navigationTitle("Navigation Link")
                        .navigationBarHidden(true)
                        
                        Button("메인으로 돌아가기") {}
                            .font(.paragraph1)
                            .foregroundColor(Color("Gray03"))
                    } // VStack
                    .padding(.horizontal, 40)
                    .padding(.top, 55)
                    .padding(.bottom, 100)
                    .background(Color("Gray01"))
                    .cornerRadius(45)
                } // VStack
            }
        } // ZStack
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .navigationBarItems(leading: backButton) // 커스텀 Back Button 추가
    } // body
}

struct PreRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        PreRecordingView()
    }
}
