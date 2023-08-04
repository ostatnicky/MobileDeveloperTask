//
//  DailyViewModel.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import Foundation

struct Response: Hashable, Codable {
    let title: String
}


class DailyViewModel: ObservableObject {
    @Published var daily: [Response] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=zJyBH3jhtKmwTTvxa83aJV7gBioOq00jjHqfjNbG") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let daily = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.daily = [daily]
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

