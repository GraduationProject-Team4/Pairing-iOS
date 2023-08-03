//
//  AnalysisResultView.swift
//  Pairing
//
//  Created by YOUJIM on 2023/08/02.
//

import SwiftUI

// MARK: - 환경음 분석 결과 화면

struct AnalysisResultView: View {
    
    // MARK: - Properties
    
    @State private var pinOffset: CGFloat = 0
    @State private var pinCurrentLocation: CGFloat = 0
    @State private var alertDecibel: CGFloat = 0
    
    var averageDecibel = 60
    var maxDecibel = 150
    var representSound = "사이렌"
    var sounds = [
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill")),
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill")),
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill")),
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill"))
    ]
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Image("EnviromentBackground")
            
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("지금 내 주위의 소리는 🤔\n평균적으로 \(averageDecibel)dB, 최대 \(maxDecibel)dB")
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                        .frame(width: 340, alignment: .leading)
                    
                    Text("이 곳에서는 이런 소리들이 들려요!")
                        .frame(width: 340, alignment: .leading)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                    
                    ScrollView() {
                        Spacer()
                        VStack(spacing: 10) {
                            ForEach(sounds) { sound in
                                VStack {
                                    SoundCell(name: sound.name, image: sound.image)
                                }
                            }
                            .frame(width: 340, height: 60)
                        } //: VStack
                        Spacer(minLength: 16)
                    } //: Scroll
                    .frame(width: 400, height: 250)
                    .padding(.bottom, 30)
                    
                    ZStack {
                        ZStack {
                            Rectangle()
                                .frame(width: 320, height: 5)
                                .foregroundColor(Color("Purple03"))
                                .cornerRadius(20)
                            
                            VStack(spacing: 0) {
                                Text("60db")
                                    .font(.system(size: 12))
                                
                                Rectangle()
                                    .frame(width: 1, height: 30)
                            } //: VStack
                            .position(CGPoint(x: 70, y: 23))
                            .foregroundColor(Color("Purple02"))
                            
                            VStack(spacing: 0) {
                                Text("120db")
                                    .font(.system(size: 12))
                                
                                Rectangle()
                                    .frame(width: 1, height: 30)
                            } //: VStack
                            .position(CGPoint(x: 170, y: 23))
                            .foregroundColor(Color("Purple02"))
                            
                            VStack(spacing: 0) {
                                Text("180db")
                                    .font(.system(size: 12))
                                
                                Rectangle()
                                    .frame(width: 1, height: 30)
                            } //: VStack
                            .position(CGPoint(x: 270, y: 23))
                            .foregroundColor(Color("Purple02"))
                            
                            Image("decibelPin")
                                .position(CGPoint(x: pinOffset, y: 10))
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            // TODO: alertDecibel 식 수정하기
                                            pinOffset = gesture.translation.width + pinCurrentLocation
                                            alertDecibel = pinOffset
                                        }
                                        .onEnded { gesture in
                                            pinCurrentLocation = pinOffset
                                        }
                                ) //: Gesture
                        } //: ZStack
                    } //: ZStack
                    .frame(width: 320, height: 60, alignment: .center)
                    
                    Text("지금 설정한 데시벨은 \(Int(alertDecibel)) 데시벨이고,\n\(Int(alertDecibel)) 데시벨 수준의 대표적인 소리는 \(representSound)이 있어요!")
                        .frame(width: 340, height: 50)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                    
                    Button("150 데시벨 이상이 되면 알림을 받을래요") {}
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .frame(width: 370, height: 48)
                        .background(Color("Purple03"))
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                    
                    Button("실시간 알림은 받고싶지 않아요") {}
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .frame(width: 370, height: 30)
                        .foregroundColor(Color("Purple02"))
                } // VStack
                .padding(.horizontal, 40)
                .padding(.top, 50)
                .padding(.bottom, 80)
                .background(Color("Gray01"))
                .cornerRadius(70)
            } // VStack
        } // ZStack
    } //: Body
}

// MARK: - Preview

struct AnalysisResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisResultView()
    }
}
