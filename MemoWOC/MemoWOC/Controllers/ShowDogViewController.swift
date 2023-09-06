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
    
    let refreshButton: UIButton = {
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
        view.addSubview(refreshButton)
        
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dogImageView.widthAnchor.constraint(equalToConstant: 280),
            dogImageView.heightAnchor.constraint(equalToConstant: 280),
            
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20),
            refreshButton.widthAnchor.constraint(equalToConstant: 200),
            refreshButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func loadRandomDogImage() {
        dogImageView.image = loadingImage
        dogImageView.tintColor = .systemYellow
        
        DogImageService.getRandomDogImage { [weak self] image in
            DispatchQueue.main.async {
                self?.dogImageView.image = image
            }
        }
    }
    
    func setAddTarget() {
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    @objc func refreshButtonTapped() {
        loadRandomDogImage()
    }
}

