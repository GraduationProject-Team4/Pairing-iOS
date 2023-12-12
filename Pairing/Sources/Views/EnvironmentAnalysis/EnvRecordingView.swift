//
//  EnvironmentRecordingView.swift
//  Pairing
//
//  Created by 서은수 on 2023/08/03.
//

import SwiftUI

import AVFoundation

// MARK: - 환경 분석 녹음 중 화면
// TODO: - 주변 환경음 분석 레포트 화면이랑 합친 후에 화면 전환 작업 수정 필요함
struct EnvRecordingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State public var beforeEnvReport: Bool
    @State private var showNextScreen: Bool = false
    @State public var maxDecibelsThreshold: Float = 80.0 // 기준 데시벨 설정
    
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
                    Text(beforeEnvReport ? "주변 소리를\n듣고 있습니다..." : "실시간으로 소리를\n듣고 있어요...")
                        .padding(.top, 30)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                    Text(beforeEnvReport ? "수집되는 소리는 환경 분석에만 사용될 뿐, 저장되지 않아요!" : "설정하신 소리보다 더 큰 소리가 나면 알려드릴게요!")
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
                
                NavigationLink(destination: AnalysisResultView(), isActive: $showNextScreen) { EmptyView() }
            } // ZStack
        } // Navi
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .onAppear {
            if beforeEnvReport {
                // 3초 후에 runDelayedFunction() 함수를 실행합니다.
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.showNextScreen.toggle()
                    print("EEE")
                }
            }
            
            // TODO: - 특정 데시벨 이상의 소리를 감지했을 때 경고창 화면으로 전환하는 기능 추가
            else {
                let audioRecorder = AVAudioRecorder()
                let audioSession = AVAudioSession.sharedInstance()
                
                do {
                    try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                    try audioSession.setActive(true)
                    
                    audioRecorder.isMeteringEnabled = true
                    audioRecorder.record()
                    
                    let timer = Timer(timeInterval: 0.5, repeats: true) { _ in
                        audioRecorder.updateMeters()
                        let averageDecibels = audioRecorder.averagePower(forChannel: 0)
                        
                        print(averageDecibels)
                        
                        // MARK: 사용자가 설정한 최대 데시벨을 넘을 경우 경고 화면으로 전환
                        if averageDecibels > maxDecibelsThreshold {
                            print("최대 데시벨 초과")
                            
                            beforeEnvReport.toggle()
                            showNextScreen.toggle()
                        }
                    }
                    
                    RunLoop.current.add(timer, forMode: .default)
                } catch {
                    print("오디오 녹음 시작 전 에러 발생")
                }
            }
        }
    }
}
