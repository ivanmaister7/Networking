//
//  CatService.swift
//  CatsApp
//
//  Created by Master on 14.06.2022.
//

import Foundation

public class AnimalService: ObservableObject {
    @Published private var animals: [CatPost] = []
    
    public init(limit: Int, type: AnimalType){
        let urlSession = URLSession(configuration: .default)
        let url = type == .dogs ?
            URL(string: "https://api.thedogapi.com/v1/images/search?limit=\(limit)")! :
            URL(string: "https://api.thecatapi.com/v1/images/search?limit=\(limit)")!
        let dataTask = urlSession.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            guard let catsPost = try? JSONDecoder().decode([CatPost].self, from: data) else { return }
            DispatchQueue.main.async {
                self.animals = catsPost
            }
        }
        dataTask.resume()
    }
    
    public func getAnimals() -> [CatPost]{
        return self.animals
    }
}

public enum AnimalType{
    case cats
    case dogs
}
