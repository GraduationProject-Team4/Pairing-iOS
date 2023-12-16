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
    @ObservedObject var networkManager = NetworkManager()
    
    @State public var recordFile: Data
    
    @State private var pinOffset: CGFloat = 117
    @State private var pinCurrentLocation: CGFloat = 117
    @State private var alertRange: String = "보통인 정도"
    @State private var showNextScreen: Bool = false
    @State private var representSound: String = "카페 소음"
    @State private var maxDecibelsThreshold: Float = 0.0
    
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
        ZStack {
            Image("EnviromentBackground")
            
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("지금 내 주위의 소리는 🤔")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                        .foregroundColor(Color("Purple04"))
                        .frame(width: 330, alignment: .leading)
                    
                    Text("이 곳에서는 이런 소리들이 들려요!")
                        .font(.paragraph3)
                        .foregroundColor(Color("Purple02"))
                        .frame(width: 330, alignment: .leading)
                    
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
                            Image("DecibelLine")
                                .frame(width: 320, height: 5)
                            
                            VStack(spacing: 0) {
                                Text("조용함")
                                    .font(.system(size: 12))
                            } //: VStack
                            .position(CGPoint(x: 25, y: 50))
                            .foregroundColor(Color("Purple04"))
                            
                            VStack(spacing: 0) {
                                Text("보통임")
                                    .font(.system(size: 12))
                            } //: VStack
                            .position(CGPoint(x: 115, y: 50))
                            .foregroundColor(Color("Purple04"))
                            
                            VStack(spacing: 0) {
                                Text("조금 시끄러움")
                                    .font(.system(size: 12))
                            } //: VStack
                            .position(CGPoint(x: 205, y: 50))
                            .foregroundColor(Color("Purple04"))
                            
                            VStack(spacing: 0) {
                                Text("많이 시끄러움")
                                    .font(.system(size: 12))
                            } //: VStack
                            .position(CGPoint(x: 295, y: 50))
                            .foregroundColor(Color("Purple04"))
                            
                            Image("decibelPin")
                                .position(CGPoint(x: pinOffset, y: 5))
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            pinOffset = gesture.translation.width + pinCurrentLocation
                                        }
                                        .onEnded { gesture in
                                            if pinOffset < 70 {
                                                pinOffset = 27
                                                alertRange = "조용한 정도"
                                                representSound = "백색 소음"
                                                maxDecibelsThreshold = -50
                                            }
                                            else if pinOffset >= 70 && pinOffset < 160 {
                                                pinOffset = 117
                                                alertRange = "보통인 정도"
                                                representSound = "카페 소음"
                                                maxDecibelsThreshold = -40
                                            }
                                            else if pinOffset >= 160 && pinOffset < 250 {
                                                pinOffset = 207
                                                alertRange = "조금 시끄러운 정도"
                                                representSound = "대화 소음"
                                                maxDecibelsThreshold = -30
                                            }
                                            else {
                                                pinOffset = 297
                                                alertRange = "많이 시끄러운 정도"
                                                representSound = "사이렌, 충돌음"
                                                maxDecibelsThreshold = -20
                                                
                                            }
                                            pinCurrentLocation = pinOffset
                                        }
                                ) //: Gesture
                        } //: ZStack
                    } //: ZStack
                    .frame(width: 320, height: 60, alignment: .center)
                    
                    Text("지금 설정한 소음 정도는 \(alertRange)고,\n해당 소음 정도의 대표적인 소리는 \(representSound)이 있어요!")
                        .frame(width: 340, height: 50)
                        .foregroundColor(Color("Purple04"))
                        .font(.paragraph5)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        self.showNextScreen.toggle()
                    } label: {
                        Text("실시간 알림을 받을래요")
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
                .padding(.top, 45)
                .padding(.bottom, 80)
                .background(Color("Gray01"))
                .cornerRadius(32)
            } // VStack
            NavigationLink(destination: EnvRecordingView(beforeEnvReport: false, maxDecibel: maxDecibelsThreshold), isActive: $showNextScreen) { EmptyView() }
        } // ZStack
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .navigationBarItems(leading: backButton) // 커스텀 Back Button 추가
        .onAppear(perform: {
            networkManager.requestTestData { message, error in
                print(message)
            }
            
            progressPrediction()
        })
    } //: Body
}


extension AnalysisResultView {
    func progressPrediction() {
        do {
            networkManager.postWavFile(
                responseDataType: PredictResponse.self, 
                file: recordFile) { result in
                    print(result)
                }
        }
        catch {
            print("파일을 읽어올 수 없습니다: \(error)")
        }
    }
}

// MARK: - Preview

//struct AnalysisResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnalysisResultView()
//    }
//}
