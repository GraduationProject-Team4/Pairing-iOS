//
//  RealTimeRecordingView.swift
//  Pairing
//
//  Created by YOUJIM on 2023/07/26.
//

import SwiftUI

struct RealTimeRecordingView: View {
    // MARK: - PROPERTIES
    
    // TODO: 일단 더미로 놓고 나중에 API 연결하면 업데이트하기
    @State private var script: [String] = [
        "아 집에가고싶다",
        "야 너도? 나도",
        "우리 근데 집에 가도 할 일이 없는데",
        "맞긴해",
        "그럼 집에 가지말까",
        "좋은 생각인 것 같아",
        "집에 안가면 뭐하지",
        "발로란트 하러 갈까",
        "좋은 생각이야",
        "아 집에가고싶다",
        "야 너도? 나도",
        "우리 근데 집에 가도 할 일이 없는데",
        "맞긴해",
        "그럼 집에 가지말까",
        "좋은 생각인 것 같아",
        "집에 안가면 뭐하지",
        "발로란트 하러 갈까",
        "좋은 생각이야"
    ]
    
    @State private var keywords: [String] = [
        "집에가고싶다",
        "집에 가지말까",
        "발로란트"
    ]
    
    var body: some View {
        ZStack {
            Image("RealTimeScriptBackground")
            
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("대화를 녹음하고 있어요...")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .frame(width: 340, alignment: .leading)
                    
                    Text("휴대폰을 대화가 잘 들리게 위치해주세요.\n대화 소리가 겹치면 제대로 인식이 되지 않을 수 있으니 유의하세요.")
                        .multilineTextAlignment(.leading)
                        .frame(width: 340, alignment: .leading)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                    
                    Text("실시간 대본")
                        .font(.system(size: 15))
                        .frame(width: 340, alignment: .leading)
                        .bold()
                    
                    ScrollView() {
                        Spacer(minLength: 16)
                        
                        ForEach(script, id: \.self, content: {
                            Text($0)
                                .frame(width: 300, alignment: .leading)
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                        })
                        
                        Spacer(minLength: 16)
                    }
                    .frame(width: 340, height: 200)
                    .background(.white)
                    .cornerRadius(16)
                    
                    Text("키워드 요약")
                        .font(.system(size: 15))
                        .frame(width: 340, alignment: .leading)
                        .bold()
                    
                    ZStack {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Yellow04"))
                                .frame(width: 160)
                            
                            Text(keywords[0])
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .fontWeight(.semibold)
                        }
                        .position(x: 170, y: 100)
                        
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Yellow05"))
                                .frame(width: 130)
                            
                            Text(keywords[1])
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                        }
                        .position(x: 60, y: 60)
                        
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Yellow02"))
                                .frame(width: 100)
                            
                            Text(keywords[2])
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        }
                        .position(x: 280, y: 70)
                    }
                    .frame(width: 340, height: 200)
                    
                    Button("대화를 요약해주세요") {}
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .frame(width: 370, height: 48)
                        .background(Color("Yellow05"))
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                    
                    Button("녹음을 중지할래요") {}
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .frame(width: 370, height: 30)
                        .foregroundColor(Color.gray)
                } // VStack
                .padding(.horizontal, 40)
                .padding(.top, 50)
                .padding(.bottom, 80)
                .background(Color("Gray01"))
                .cornerRadius(70)
            } // VStack
        } // ZStack
    } // body
}

struct RealTimeRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeRecordingView()
    }
}
