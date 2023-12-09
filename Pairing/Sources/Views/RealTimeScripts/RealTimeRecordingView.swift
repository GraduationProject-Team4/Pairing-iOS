//
//  RealTimeRecordingView.swift
//  Pairing
//
//  Created by YOUJIM on 2023/07/26.
//

import SwiftUI
import AVFoundation

struct RealTimeRecordingView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var networkManager = NetworkManager()
    @State var audioRecorder: AVAudioRecorder?
    
    // 커스텀한 Back button
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // 이전 화면으로 돌아가기
        }) {
            Image(systemName: "chevron.backward") // 뒤로가기 아이콘
                .foregroundColor(.black)
        }
    }
    
    // TODO: 일단 더미로 놓고 나중에 API 연결하면 업데이트하기
    var script: [String] = [
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
                            let pattern = "\\d+\\.\\s*(.+)"

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
                                print(resultArray)
                                self.keywords = resultArray
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
                    
                    Button("녹음을 중지할래요") {}
                        .font(.paragraph1)
                        .frame(width: 370, height: 30)
                        .foregroundColor(Color("Gray03"))
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
            // 권한 받기
            getAudioPermission()
            // 음성 녹음 시작
            do {
                var recordURL: URL {
                    var documentsURL: URL = {
                        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                        return paths.first!
                    }()
                    let fileName = UUID().uuidString + ".wav"
                    let url = documentsURL.appendingPathComponent(fileName)
                    return url
                }
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.record, mode: .default, options: .duckOthers)
                try audioSession.setActive(true)
                let settings: [String: Any] = [
                    AVFormatIDKey: Int(kAudioFormatLinearPCM),
                    AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                    AVEncoderBitRateKey: 320_000,
                    AVNumberOfChannelsKey: 2,
                    AVSampleRateKey: 44_100.0
                ]
                self.audioRecorder = try AVAudioRecorder(url: recordURL, settings: settings)
                audioRecorder?.record()
            } catch {
                print("오디오 녹음 시작 전 에러 발생: \(error.localizedDescription)")
            }
            // 5초에 한번씩 stt api 실행
            
        }
        .onDisappear {
            // 음성 녹음 중지
            if let recorder: AVAudioRecorder = audioRecorder {
                recorder.stop()
                let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(false)
                    print("음성녹음 중지")
                } catch {
                    print("음성녹음 중지 실패")
                    fatalError(error.localizedDescription)
                }
            }
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

struct RealTimeRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeRecordingView()
    }
}
