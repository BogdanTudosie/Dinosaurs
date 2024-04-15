//
//  DinosaurDetailView.swift
//  ApexPredators
//
//  Created by Bogdan Tudosie on 15.4.2024.
//

import SwiftUI
import MapKit

struct DinosaurDetailView: View {
    let predator: ApexPredator
    @State var cameraPos: MapCameraPosition
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // Top background image
                    Image(predator.type.rawValue).resizable().scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear
                                                                 , location: 0),
                                                   Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    Image(predator.image).resizable().scaledToFit().frame(width: reader.size.width/1.5, height: reader.size.height / 3)
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                VStack(alignment: .leading) {
                    // text
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Map
                    NavigationLink {
                        DinosaurMapView(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 360, pitch: 45)))
                    } label: {
                        Map(position: $cameraPos) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height:125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                            
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    
                    Text("Appears in: ").font(.title3)
                        .padding(.vertical, 2)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("◦" + movie)
                            .font(.subheadline)
                    }
                    
                    Text("Movie scenes:").font(.title3).padding(.vertical, 3)
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie).font(.title2).padding(.vertical, 1)
                        Text(scene.sceneDescription).padding(.bottom, 15)
                    }
                    
                    Text("Read more here: ").font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption).foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: reader.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        DinosaurDetailView(predator: Predators().apexPredators[10], cameraPos: .camera(MapCamera(centerCoordinate: Predators().apexPredators[10].location, distance: 15000))).preferredColorScheme(.dark)
    }
}
