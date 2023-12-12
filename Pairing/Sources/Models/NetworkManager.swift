//
//  NetworkManager.swift
//  Pairing
//
//  Created by 서은수 on 12/4/23.
//

import Foundation
import googleapis

class NetworkManager: ObservableObject {
    
    func requestKeywords(script: String, completionHandler: @escaping (String?, Error?) -> ()) {
        let apiKey = "Open_AI_Key"
        let model = "text-davinci-003"
        let prompt = "[\(script)]\n위의 대괄호 안의 텍스트에서 키워드 최소 1개, 최대 3개만 뽑아줘 1. 2. 3. 이런 식으로 번호로 표시하고, 번호 하나당 하나의 단어만 말해. 그러나 괄호 안이 비어있는 경우에는 아무 말도 하지마"
        
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
        print("ChatGPT Request Body \(requestBody)")
        
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
