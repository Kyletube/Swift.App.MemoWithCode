//
//  ViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var mainImageView: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "MemoImage"))
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    private lazy var mainTodoButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .systemYellow
        bt.layer.cornerRadius = 5
        bt.clipsToBounds = true
        bt.setTitle("할 일 보기", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        bt.addTarget(self, action: #selector(todoButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var mainCompleteButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .orange
        bt.layer.cornerRadius = 5
        bt.clipsToBounds = true
        bt.setTitle("완료한 일 보기", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 18)
        bt.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    var mainStackView: UIStackView = {
        let st = UIStackView()
        st.spacing = 20
        st.axis = .vertical
        st.alignment = .center
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainImageView)
        mainStackView.addArrangedSubview(mainTodoButton)
        mainStackView.addArrangedSubview(mainCompleteButton)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainTodoButton.translatesAutoresizingMaskIntoConstraints = false
        mainCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            mainTodoButton.heightAnchor.constraint(equalToConstant: 45),
            mainTodoButton.widthAnchor.constraint(equalToConstant: 200),
            
            mainCompleteButton.heightAnchor.constraint(equalToConstant: 45),
            mainCompleteButton.widthAnchor.constraint(equalToConstant: 200),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    @objc func todoButtonTapped() {
        let todoViewController = TodoViewController()
        let navigationController = UINavigationController(rootViewController: todoViewController)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func completeButtonTapped() {
        
    }
}


