//
//  ModelData.swift
//  Landmarks
//
//  Created by Brandon Williams on 2/19/25.
//

import Foundation

@Observable
class ModelData {
    // create array of landmarks loaded from JSON
    var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
}

// <T: Decodable> --> Generic Type "T", "T" (User, LandMark, Coordinates, etc) must conform to Decodable (i.e can be decoded from data source such as JSON, CSV, etc)
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    // attempts to find file in app's resource bundle (where assets, jsons, etc are stored)
    // guard statements run if condition is NOT met
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    }
    catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch {
        fatalError("Couldn't parse \(filename) as \(T.self): \n\(error)")
    }
}
