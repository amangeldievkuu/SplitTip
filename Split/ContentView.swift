//
//  ContentView.swift
//  Split
//
//  Created by Kutman Amangeldiev on 2024/1/10.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calculate the total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalCheck : Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of peoples", selection: $numberOfPeople){
                        ForEach(2..<30){people in
                            Text("\(people) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentages", selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount for the Check"){
                    Text(totalCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    if amountIsFocused {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
