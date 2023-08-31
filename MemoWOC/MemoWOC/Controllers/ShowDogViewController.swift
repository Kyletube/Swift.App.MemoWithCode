//
//  ShowDogViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/30.
//

import UIKit

class ShowDogViewController: UIViewController {
    
    let dogImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let refreshButoon: UIButton = {
        $0.setTitle("더 보기", for: .normal)
        $0.backgroundColor = .systemYellow
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .custom))
    
    let loadingImage: UIImage? = UIImage(systemName: "clock.arrow.circlepath")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        loadRandomDogImage()
        setAddTarget()
    }
    
    func setUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(dogImageView)
        view.addSubview(refreshButoon)
        
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        refreshButoon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dogImageView.widthAnchor.constraint(equalToConstant: 280),
            dogImageView.heightAnchor.constraint(equalToConstant: 280),
            
            refreshButoon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshButoon.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20),
            refreshButoon.widthAnchor.constraint(equalToConstant: 200),
            refreshButoon.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func loadRandomDogImage() {
        dogImageView.image = loadingImage
        dogImageView.tintColor = .systemYellow
        
        guard let url = URL(string: "https://api.thedogapi.com/v1/images/search") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    if let firstImage = jsonArray?.first,
                       let imageUrlString = firstImage["url"] as? String,
                       let imageUrl = URL(string: imageUrlString),
                       let imageData = try? Data(contentsOf: imageUrl),
                       let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self?.dogImageView.image = image
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func setAddTarget() {
        refreshButoon.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    @objc func refreshButtonTapped() {
        loadRandomDogImage()
    }
}

