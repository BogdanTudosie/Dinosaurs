//
//  ContentView.swift
//  ApexPredators
//
//  Created by Bogdan Tudosie on 11.4.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var predators = Predators()
    @State var searchString: String = ""
    @State var alphabetical: Bool = false
    @State var currentSelection = PredatorType.all
    
    var filteredDinosaurs:[ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchString)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinosaurs) { predator in
                NavigationLink {
                    DinosaurDetailView(predator: predator, cameraPos: .camera(MapCamera(centerCoordinate: predator.location, distance: 15000)))
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1.0)
                        
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical, 13)
                                .padding(.horizontal, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchString)
            .autocorrectionDisabled()
            .animation(.default, value: searchString)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat").symbolEffect(.bounce, value: alphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation(.easeIn)) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
