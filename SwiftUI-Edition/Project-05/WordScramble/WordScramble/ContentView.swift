//
//  ContentView.swift
//  WordScramble
//
//  Created by Zhishen Wen on 8/7/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var toggleIsOn = true
    
    var body: some View {
        List {
            Toggle(isOn: $toggleIsOn) {
                Text("Dark mode: \(toggleIsOn ? "On" : "Off")")
            }

            Section(header: Text("Image")) {
                ForEach(0..<3) {
                    Image(systemName: "\($0).circle")
                }
            }
        }
        .listStyle(GroupedListStyle())
//        .colorScheme(toggleIsOn ? .dark : .light) // won't change the status bar style
        .preferredColorScheme(toggleIsOn ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
