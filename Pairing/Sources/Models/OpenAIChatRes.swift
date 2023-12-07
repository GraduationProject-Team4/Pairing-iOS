//
//  OpenAIChatRes.swift
//  Pairing
//
//  Created by 서은수 on 12/4/23.
//

import Foundation

// Res
struct OpenAIChatResponse: Decodable {
    var warning: String?
    var id: String
    var object: String
    var created: TimeInterval
    var model: String
    var choices: [Choice]
    var usage: Usage
}

struct Choice: Decodable {
    var text: String
    var index: Int
    var logprobs: String?
    var finish_reason: String
}

struct Usage: Decodable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}
