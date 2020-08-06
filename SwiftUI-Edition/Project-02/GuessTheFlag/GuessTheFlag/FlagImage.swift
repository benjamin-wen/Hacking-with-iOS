//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Zhishen Wen on 8/6/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let image: Image
    
    var body: some View {
        image
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
