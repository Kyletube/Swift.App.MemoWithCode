//
//  DogImageService.swift
//  MemoWOC
//
//  Created by Kyle on 2023/09/06.
//

import Foundation
import UIKit

class DogImageService {
    static func getRandomDogImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https://api.thedogapi.com/v1/images/search") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    if let firstImage = jsonArray?.first,
                       let imageUrlString = firstImage["url"] as? String,
                       let imageUrl = URL(string: imageUrlString),
                       let imageData = try? Data(contentsOf: imageUrl),
                       let image = UIImage(data: imageData) {
                        completion(image)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}

