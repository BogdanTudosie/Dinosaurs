//
//  MovieScene.swift
//  ApexPredators
//
//  Created by Bogdan Tudosie on 11.4.2024.
//

import Foundation

struct MovieScene: Decodable, Identifiable {
    let id: Int
    let movie: String
    let sceneDescription: String
}
