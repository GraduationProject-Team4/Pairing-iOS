//
//  RealTimeRecordingView.swift
//  Pairing
//
//  Created by YOUJIM on 2023/07/26.
//

import SwiftUI
import AVFoundation
import googleapis

struct RealTimeRecordingView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var networkManager = NetworkManager()
    @State var audioRecorder: AVAudioRecorder?
    @State private var shouldNavigateToHome = false
    
    let SAMPLE_RATE = 16000
    @State var audioData: NSMutableData!
    
    // 커스텀한 Back button
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // 이전 화면으로 돌아가기
        }) {
            Image(systemName: "chevron.backward") // 뒤로가기 아이콘
                .foregroundColor(.black)
        }
    }
    
    @State var script: [String] = []
    
    @State private var keywords: [String] = ["", "", ""]
    
    var body: some View {
        ZStack {
            Image("RealTimeScriptBackground")
            
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("대화를 녹음하고 있어요...")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 24))
                        .foregroundColor(Color("Yellow06"))
                        .frame(width: 350, alignment: .leading)
                    
                    Text("휴대폰을 대화가 잘 들리게 위치해주세요.\n대화 소리가 겹치면 인식이 되지 않을 수 있으니 유의하세요.")
                        .multilineTextAlignment(.leading)
                        .frame(width: 350, alignment: .leading)
                        .foregroundColor(Color("Gray04"))
                        .font(.paragraph5)
                    
                    Text("실시간 대본")
                        .font(.paragraph1)
                        .foregroundColor(Color("Yellow06"))
                        .frame(width: 350, alignment: .leading)
                    
                    ScrollView() {
                        Spacer(minLength: 16)
                        
                        ForEach(script, id: \.self, content: {
                            Text($0)
                                .frame(width: 300, alignment: .leading)
                                .foregroundColor(Color("Yellow06"))
                                .font(.paragraph4)
                        })
                        
                        Spacer(minLength: 16)
                    }
                    .frame(width: 350, height: 200)
                    
                    .background(.white)
                    .cornerRadius(16)
                    
                    Text("키워드 요약")
                        .font(.paragraph1)
                        .foregroundColor(Color("Yellow06"))
                        .frame(width: 350, alignment: .leading)
                    
                    ZStack {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Yellow04"))
                                .frame(width: 160)
                            
                            Text(keywords[0])
                                .foregroundColor(.white)
                                .font(.custom("AppleSDGothicNeo-Bold", size: 24))
                        }
                        .position(x: 170, y: 90)
                        
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Yellow05"))
                                .frame(width: 130)
                            
                            Text(keywords[1])
                                .foregroundColor(.white)
                                .font(.paragraph1)
                        }
                        .position(x: 60, y: 60)
                        
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Yellow02"))
                                .frame(width: 100)
                            
                            Text(keywords[2])
                                .font(.title5)
                                .fontWeight(.semibold)
                        }
                        .position(x: 280, y: 70)
                    }
                    .frame(width: 340, height: 200)
                    
                    Button("대화를 요약해주세요") {
                        let scripts = script.joined(separator: "\n")
                        networkManager.requestKeywords(script: scripts) { keywords, err in
                            let inputString = keywords ?? "Blank"
                            
                            // 정규표현식을 사용하여 1. 2. 3. 뒤의 글자들을 추출
                            let pattern = "\\d+\\.\\s*([^,\\d]+)\\s*(?=\\d+\\.|$)"
                            
                            do {
                                let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
                                let matches = regex.matches(in: inputString, options: [], range: NSRange(location: 0, length: inputString.utf16.count))
                                
                                var resultArray: [String] = []
                                
                                for match in matches {
                                    if let range = Range(match.range(at: 1), in: inputString) {
                                        let substring = String(inputString[range])
                                        resultArray.append(substring)
                                    }
                                }
                                
                                if !resultArray.isEmpty {
                                    if resultArray.count == 1 {
                                        resultArray.append("")
                                        resultArray.append("")
                                    } else if resultArray.count == 2 {
                                        resultArray.append("")
                                    }
                                    self.keywords = resultArray
                                } else {
                                    self.keywords = ["Blank", "Blank", "Blank"]
                                }
                            } catch {
                                print("Error creating regular expression: \(error)")
                            }
                        }
                    }
                    .font(.paragraph1)
                    .frame(width: 370, height: 48)
                    .background(Color("Yellow05"))
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    
                    Button("녹음을 중지할래요") {
                        shouldNavigateToHome.toggle()
                    }
                        .font(.paragraph1)
                        .frame(width: 370, height: 30)
                        .foregroundColor(Color("Gray03"))
                        .fullScreenCover(isPresented: $shouldNavigateToHome) {
                            HomeView()}
                } // VStack
                .padding(.horizontal, 40)
                .padding(.top, 50)
                .padding(.bottom, 80)
                .background(Color("Gray01"))
                .cornerRadius(70)
            } // VStack
        } // ZStack
        .navigationBarBackButtonHidden(true) // 기본 Back Button 숨김
        .onAppear {
            AudioController.sharedInstance.delegate = self
            // 권한 받기
            getAudioPermission()
            // 음성 녹음 시작
            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.record, mode: .default, options: .duckOthers)
                audioData = NSMutableData()
                _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
                SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
                _ = AudioController.sharedInstance.start()
            } catch {
                print("오디오 녹음 시작 전 에러 발생: \(error.localizedDescription)")
            }
        }
        .onDisappear {
            _ = AudioController.sharedInstance.stop()
            SpeechRecognitionService.sharedInstance.stopStreaming()
        }
    } // body
}

func getAudioPermission() {
    // 권한
    AVAudioSession.sharedInstance().requestRecordPermission { (accepted) in
        if accepted {
            print("permission granted")
        }
    }
}

extension RealTimeRecordingView: AudioControllerDelegate {
    func processSampleData(_ data: Data) -> Void {
        audioData.append(data)
        
        // We recommend sending samples in 100ms chunks
        let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
                                                    * Double(SAMPLE_RATE) /* samples/second */
                                                    * 2 /* bytes/sample */);
        
        if (audioData.length > chunkSize) {
            SpeechRecognitionService.sharedInstance.streamAudioData(audioData) { [self] (response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let response = response {
                    print(response)
                    for result in response.resultsArray! {
                        if let result = result as? StreamingRecognitionResult {
                            if result.isFinal {
                                print("result: \(result.alternativesArray[0])")
                                let trans = result.alternativesArray[0] as? SpeechRecognitionAlternative
                                print("trans: \(trans?.transcript)")
                                
                                DispatchQueue.main.async {
                                    script.append(trans?.transcript ?? "")
                                }
                            }
                        }
                    }
                }
            }
            self.audioData = NSMutableData()
        }
    }
}

struct RealTimeRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeRecordingView()
    }
}
