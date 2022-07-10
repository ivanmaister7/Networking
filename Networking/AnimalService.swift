//
//  CatService.swift
//  CatsApp
//
//  Created by Master on 14.06.2022.
//

import Foundation

public class AnimalService: ObservableObject {
    private var limit = 1
    @Published private var cats: [CatPost] = []
    
    public init(limit: Int){
        let urlSession = URLSession(configuration: .default)
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=\(limit)")!
        let dataTask = urlSession.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            guard let catsPost = try? JSONDecoder().decode([CatPost].self, from: data) else { return }
            DispatchQueue.main.async {
                self.cats = catsPost
            }
        }
        dataTask.resume()
    }
    
    public func getCats() -> [CatPost]{
        return self.cats
    }
}
