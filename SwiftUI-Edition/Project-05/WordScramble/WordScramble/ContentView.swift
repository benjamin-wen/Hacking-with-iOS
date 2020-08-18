//
//  ContentView.swift
//  WordScramble
//
//  Created by Zhishen Wen on 8/7/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var totalScore = 0
    @State private var currentScore = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle.fill")
                    Text($0)
                }.listStyle(PlainListStyle())
                
                HStack {
                    Text("Current: \(currentScore)")
                    Spacer()
                    Text("Total: \(totalScore)")
                }
                .foregroundColor(.pink)
                .padding()
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing: Button("Restart", action: startGame))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        guard isReasonablyHard(word: answer) else {
            wordError(title: "Word too easy", message: "You can surely do better.")
            return
        }
        
        currentScore += answer.count
        totalScore += answer.count
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    /// Check whether a word is already used
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    /// Check whether a word can be made out of the letters from `rootWord`
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        guard word.count >= 3 else {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func isReasonablyHard(word: String) -> Bool {
        !rootWord.hasPrefix(word)
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    private func startGame() {
        currentScore = 0
        usedWords.removeAll()
        
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileURL) {
                let allWords = fileContent.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "kingfisher"
                return
            }
        }
        
        fatalError("Failed to load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
