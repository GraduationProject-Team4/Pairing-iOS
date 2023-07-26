//
//  RecordingView.swift
//  Pairing
//
//  Created by YOUJIM on 2023/07/24.
//

import SwiftUI

struct PreRecordingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("RealTimeScriptBackground")
                
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
                            .font(.title)
                            .bold()
                        
                        Text("준비되셨나요?\n대화가 가장 잘 들리는 위치에 휴대폰을 위치해주세요.\n대화를 보다가 키워드 요약이 필요하다면\n대화를 요약해주세요 버튼을 클릭해주세요.\n대화를 끝마치고 싶다면\n녹음을 중지할래요 버튼을 클릭해주세요.\n\n수집되는 녹음 정보는 대화가 끝난 후 곧바로 폐기돼요!")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .font(.callout)
                        
                        NavigationLink(destination: RealTimeRecordingView()) {
                            Text("유의사항을 확인했어요")
                                .bold()
                                .padding(.horizontal, 90)
                                .padding(.vertical, 15)
                                .background(Color("Yellow05"))
                                .foregroundColor(Color.white)
                                .cornerRadius(8)
                        }
                        .navigationTitle("Navigation Link")
                        .navigationBarHidden(true)
                        
                        Button("메인으로 돌아가기") {}
                            .foregroundColor(Color.gray)
                            .bold()
                    } // VStack
                    .padding(.horizontal, 40)
                    .padding(.top, 55)
                    .padding(.bottom, 100)
                    .background(Color("Gray01"))
                    .cornerRadius(45)
                } // VStack
            }
        } // ZStack
    } // body
}

struct PreRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        PreRecordingView()
    }
}
