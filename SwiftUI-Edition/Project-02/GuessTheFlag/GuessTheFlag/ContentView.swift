//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zhishen Wen on 7/27/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore = 0
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var showingScore = false
    
    var body: some View {
        ZStack {
            // background
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                Text("Score: \(userScore)").foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) { () -> Alert in
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userScore += 1
            scoreTitle = "Correct. Score +1 🍻"
            scoreMessage = "Your score is \(userScore)"
        } else {
            userScore -= 1
            scoreTitle = "Wrong 🙃"
            scoreMessage = "That’s the flag of \(countries[number])"
        }

        showingScore = true
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
