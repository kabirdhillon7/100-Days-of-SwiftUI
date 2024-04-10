//
//  ContentView.swift
//  C1. Converter
//
//  Created by Kabir Dhillon on 4/8/24.
//

import SwiftUI

enum KeyboardFocus {
    case length, temperature, time, volume
}

struct ContentView: View {
    
    @FocusState private var keyboardFocus: KeyboardFocus?
    
    @State private var lengthInput = ""
    @State private var lengthInputSelection: UnitLength = .meters
    @State private var lengthOutputSelection: UnitLength = .meters
    private let lengthOptions: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    var lengthOutput: Double {
        let input = Double(lengthInput) ?? 0
        let measurement = Measurement(value: input, unit: lengthInputSelection)
        return measurement.converted(to: lengthOutputSelection).value
    }
    
    @State private var tempInput = ""
    @State private var tempInputSelection: UnitTemperature = .celsius
    @State private var tempOutputSelection: UnitTemperature = .celsius
    private let tempOptions: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    var tempOutput: Double {
        let input = Double(tempInput) ?? 0
        let measurement = Measurement(value: input, unit: tempInputSelection)
        return measurement.converted(to: tempOutputSelection).value
    }
    
    @State private var timeInput = ""
    @State private var timeInputSelection: UnitDuration = .seconds
    @State private var timeOutputSelection: UnitDuration = .seconds
    private let timeOptions: [UnitDuration] = [.seconds, .minutes, .hours]
    
    var timeOutput: Double {
        let input = Double(timeInput) ?? 0
        let measurement = Measurement(value: input, unit: timeInputSelection)
        return measurement.converted(to: timeOutputSelection).value
    }
    
    @State private var volumeInput = ""
    @State private var volumeInputSelection: UnitVolume = .milliliters
    @State private var volumeOutputSelection: UnitVolume = .milliliters
    private let volumeOptions: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons]
    
    var volumeOutput: Double {
        let input = Double(volumeInput) ?? 0
        let measurement = Measurement(value: input, unit: volumeInputSelection)
        return measurement.converted(to: volumeOutputSelection).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Length") {
                    TextField("Enter a length", text: $lengthInput)
                        .focused($keyboardFocus, equals: .length)
                        .keyboardType(.decimalPad)
                    
                    Picker("Pick a unit", selection: $lengthInputSelection) {
                        ForEach(lengthOptions, id: \.self) { length in
                            Text(length.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(lengthOutput, format: .number)
                    
                    Picker("Pick a unit", selection: $lengthOutputSelection) {
                        ForEach(lengthOptions, id: \.self) { length in
                            Text(length.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Temperature") {
                    TextField("Enter a temperature", text: $tempInput)
                        .focused($keyboardFocus, equals: .temperature)
                        .keyboardType(.decimalPad)
                    
                    Picker("Pick a unit", selection: $tempInputSelection) {
                        ForEach(tempOptions, id: \.self) { temp in
                            Text(temp.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(tempOutput, format: .number)
                    
                    Picker("Pick a unit", selection: $tempOutputSelection) {
                        ForEach(tempOptions, id: \.self) { temp in
                            Text(temp.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Time") {
                    TextField("Enter a time", text: $timeInput)
                        .focused($keyboardFocus, equals: .time)
                        .keyboardType(.decimalPad)
                    
                    Picker("Pick a unit", selection: $timeInputSelection) {
                        ForEach(timeOptions, id: \.self) { time in
                            Text(time.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(timeOutput, format: .number)
                    
                    Picker("Pick a unit", selection: $timeOutputSelection) {
                        ForEach(timeOptions, id: \.self) { time in
                            Text(time.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Volume") {
                    TextField("Enter a volume", text: $volumeInput)
                        .focused($keyboardFocus, equals: .volume)
                        .keyboardType(.decimalPad)
                    
                    Picker("Pick a unit", selection: $volumeInputSelection) {
                        ForEach(volumeOptions, id: \.self) { volume in
                            Text(volume.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(volumeOutput, format: .number)
                    
                    Picker("Pick a unit", selection: $volumeOutputSelection) {
                        ForEach(volumeOptions, id: \.self) { volume in
                            Text(volume.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        keyboardFocus = nil
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
