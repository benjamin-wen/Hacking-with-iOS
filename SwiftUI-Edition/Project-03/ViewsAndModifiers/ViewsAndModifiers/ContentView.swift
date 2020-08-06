//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Zhishen Wen on 8/6/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    
    @State private var name = ""
    @State private var useRedText = false
    
    // view component as a proterty
    private var nameField: some View { TextField("Input your name...", text: $name) }
    
    var body: some View {
        VStack {
            nameField
            
            Text("Gryffindor")
                .font(.largeTitle)
                // environment modifier
                .foregroundColor(.blue)
            Text("Hufflepuff")
            CapsuleText(text: "I'm switch")
            
            Text("Styled text").titleStyle().watermarked("Hacking with Swift")
        }
        .font(.title)
        .foregroundColor(.red)
        .blur(radius: 0.8)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
