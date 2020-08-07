//
//  ContentView.swift
//  BetterRest
//
//  Created by Zhishen Wen on 8/7/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var coffeeAmount = 1
    
    private var recommendedBedtime: String {
        calculateBedtime()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: SectionHeader(title: "When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: SectionHeader(title: "Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: SectionHeader(title: "Daily coffee intake")) {
                    Stepper(value: $coffeeAmount, in: 1...20) {
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
                
                Section(header: SectionHeader(title: "Recommended bedtime")) {
                    Text(recommendedBedtime)
                        .font(.title)
                }
            }
            .navigationBarTitle("BetterRest")

        }
    }
    
    private func calculateBedtime() -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        let model = SleepCalculator()
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            print(error.localizedDescription)
            return "-"
        }
    }
}

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title).font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
