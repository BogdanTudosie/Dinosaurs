//
//  Predators.swift
//  ApexPredators
//
//  Created by Bogdan Tudosie on 11.4.2024.
//

import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init(){
        decodeData()
    }
    
    func decodeData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON Data \(error)")
            }
        }
    }
    
    func search(for searchString: String) -> [ApexPredator] {
        if searchString.isEmpty {
            return apexPredators
        }
        else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchString)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { firstPredator, secondPredator in
            if alphabetical {
                firstPredator.name < secondPredator.name
            }
            else {
                firstPredator.id < secondPredator.id
            }
        }
    }
    
    func filter(by type: PredatorType) {
        if type != .all {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        } else {
            apexPredators = allApexPredators
        }
    }
}
