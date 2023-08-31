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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(dogImageView)
        
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dogImageView.widthAnchor.constraint(equalToConstant: 100),
            dogImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
