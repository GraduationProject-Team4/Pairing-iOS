//
//  NetworkManager.swift
//  Pairing
//
//  Created by 서은수 on 12/4/23.
//

import Foundation

class NetworkManager: ObservableObject {
    
    func requestKeywords(script: String, completionHandler: @escaping (String?, Error?) -> ()) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            return
        }
        
        let apiKey = "Open_AI_Key"
        let model = "text-davinci-003"
        let prompt = "\(script)\n이 대화 내용에서 빈출 순으로 키워드 3개만 뽑아줘 한국어로 대답해"
        
        let temperature = 0.9
        let maxTokens = 150
        let topP = 1
        let frequencyPenalty = 0.0
        let presencePenalty = 0.6
        let stop = [" Human:", " AI:"]
        
        let requestBody : [String : Any] = [
            "model": model,
            "prompt": prompt,
            "temperature": temperature,
            "max_tokens": maxTokens,
            "top_p": topP,
            "frequency_penalty": frequencyPenalty,
            "presence_penalty": presencePenalty,
            "stop": stop
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
        
        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/completions")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(Secret.API_KEY)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let res = try JSONDecoder().decode(OpenAIChatResponse.self, from: data)
                print(String(data: data, encoding: .utf8) ?? "")
                
                DispatchQueue.main.async {
                    completionHandler(res.choices[0].text, nil)
                }
            } catch {
                completionHandler(nil, error)
                print("Error decoding JSON to struct: \(error.localizedDescription)")
                print(String(data: data, encoding: .utf8) ?? "")
            }
        }.resume()
    }
}
