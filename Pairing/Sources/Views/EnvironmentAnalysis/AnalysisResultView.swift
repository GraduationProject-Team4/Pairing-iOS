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
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var pinOffset: CGFloat = 0
    @State private var pinCurrentLocation: CGFloat = 0
    @State private var alertDecibel: CGFloat = 0
    @State private var showNextScreen: Bool = false
    
    var averageDecibel = 60
    var maxDecibel = 150
    var representSound = "사이렌"
    var sounds = [
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill")),
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill")),
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill")),
        Sound(name: "사이렌", image: Image(systemName: "light.beacon.min.fill"))
    ]
    
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
        NavigationView {
            ZStack {
                Image("EnviromentBackground")
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 15) {
                        Text("지금 내 주위의 소리는 🤔\n평균적으로 \(averageDecibel)dB, 최대 \(maxDecibel)dB")
                            .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                            .foregroundColor(Color("Purple04"))
                            .frame(width: 350, alignment: .leading)
                        
                        Text("이 곳에서는 이런 소리들이 들려요!")
                            .font(.paragraph3)
                            .foregroundColor(Color("Purple02"))
                            .frame(width: 350, alignment: .leading)
                        
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
                            .foregroundColor(Color("Purple04"))
                            .font(.paragraph5)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            self.showNextScreen.toggle()
                        } label: {
                            Text("150 데시벨 이상이 되면 알림을 받을래요")
                                .font(.paragraph1)
                                .frame(width: 370, height: 48)
                                .background(Color("Purple03"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button("실시간 알림은 받고싶지 않아요") {}
                            .font(.paragraph1)
                            .frame(width: 370, height: 30)
                            .foregroundColor(Color("Purple02"))
                    } // VStack
                    .padding(.horizontal, 40)
                    .padding(.top, 50)
                    .padding(.bottom, 80)
                    .background(Color("Gray01"))
                    .cornerRadius(70)
                } // VStack
                
                NavigationLink(destination: EnvRecordingView(beforeEnvReport: false), isActive: $showNextScreen) { EmptyView() }
            } // ZStack
        }
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .navigationBarItems(leading: backButton) // 커스텀 Back Button 추가
    } //: Body
    
    
}

// MARK: - Preview

struct AnalysisResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisResultView()
    }
}
