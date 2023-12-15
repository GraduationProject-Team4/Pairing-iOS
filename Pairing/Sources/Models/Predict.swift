//
//  PredictReq.swift
//  Pairing
//
//  Created by YOUJIM on 12/15/23.
//

import Foundation


struct PredictRequest: Encodable {
    var file: Data
}

struct PredictResponse: Decodable {
    var message: String
    var filename: String
    var predictMessage: String
    var audioPrediction: [String]
}
