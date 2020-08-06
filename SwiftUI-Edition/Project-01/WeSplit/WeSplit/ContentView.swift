//
//  ContentView.swift
//  WeSplit
//
//  Created by Zhishen Wen on 7/24/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 1
    
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tip = orderAmount * tipSelection / 100
        let grandTotal = orderAmount + tip
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = numberOfPeople + 1
        return grandTotal / Double(peopleCount)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1..<100) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Grand total")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                        .foregroundColor(self.tipPercentage == 4 ? .red : .primary)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .colorScheme(.light)
    }
}
