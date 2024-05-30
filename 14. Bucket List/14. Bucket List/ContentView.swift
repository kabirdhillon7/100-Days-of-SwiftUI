//
//  ContentView.swift
//  14. Bucket List
//
//  Created by Kabir Dhillon on 4/29/24.
//

import CoreLocation
import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var showAuthFailed: Bool = false
    
    var body: some View {
        if viewModel.isUnlocked {
            let startPosition = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
                    span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                )
            )
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(viewModel.mapStyle == .standard ? .standard : .hybrid)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
                .overlay(alignment: .topTrailing) {
                    Menu {
                        Picker("Select Map Style", selection: $viewModel.mapStyle) {
                            ForEach(ViewModel.MapStyle.allCases) { style in
                                Text(style.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.menu)
                    } label: {
                        Image(systemName: "gear.circle.fill")
                            .tint(.white)
                            .font(.system(size: 40))
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Face Not Recognized", isPresented: $viewModel.authFailed, actions: {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("OK")
                    })
                }, message: {
                    Text("Unable to unlock places. Please try again.")
                })
        }
    }
    
}

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var isUnlocked = false
        var authFailed: Bool = false
        var mapStyle: MapStyle = .standard
        
        enum MapStyle: String, CaseIterable, Identifiable {
            var id: Self { self }
            case standard, hybrid
        }
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.authFailed = true
                    }
                }
            } else {
                self.authFailed = true
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
    }
}

#Preview {
    ContentView()
}
