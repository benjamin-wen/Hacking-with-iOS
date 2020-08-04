//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zhishen Wen on 7/27/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        VStack(alignment: .leading) {
            Color(.red).edgesIgnoringSafeArea(.all)
            Text("Hello")
            Button(action: {
                print("Button was tapped.")
                self.showingAlert = true
            }) {
                Image(systemName: "pencil")
            }
            .alert(isPresented: $showingAlert) { () -> Alert in
                Alert(
                    title: Text("Hello SwiftUI!"),
                    message: Text("Before"),
                    primaryButton: .cancel(),
                    secondaryButton: .default(Text("Yes"))
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
