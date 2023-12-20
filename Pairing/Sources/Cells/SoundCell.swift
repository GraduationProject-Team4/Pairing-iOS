//
//  SoundCell.swift
//  Pairing
//
//  Created by YOUJIM on 2023/08/02.
//

import SwiftUI

// MARK: - AnalysisResultView에서 소리 셀로 쓰일 View

struct SoundCell: View {
    // MARK: - PROPERTIES
    
    @State public var name: String
    @State public var image: Image
    
    var body: some View {
        VStack() {
            HStack() {
                image
                    .tint(Color(.black))
                    .frame(width: 50, height: 50, alignment: .center)
                    .scaledToFill()
                    .cornerRadius(10)
                
                Text(name)
                    .foregroundColor(.black)
                    .font(.paragraph3)
                    .frame(alignment: .leading)
                
                Spacer()
            }
            
            Rectangle()
                .frame(width: 300, height: 0.4)
                .foregroundColor(Color("Purple01"))
        }
    }
}

struct SoundCell_Previews: PreviewProvider {
    static var previews: some View {
        SoundCell(name: "사이렌 소리", image: Image(systemName: "airpodsmax"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
