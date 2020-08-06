//
//  ViewModifiers.swift
//  ViewsAndModifiers
//
//  Created by Zhishen Wen on 8/6/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

// MARK: Title

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .clipShape(Capsule())
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

// MARK: Watermark
struct Watermark: ViewModifier {
    let text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
                .cornerRadius(2)
                .shadow(color: .gray, radius: 5, x: 3, y: 3)
        }
    }
}

extension View {
    func watermarked(_ text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
