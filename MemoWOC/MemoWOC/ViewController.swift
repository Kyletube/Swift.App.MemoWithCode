//
//  ViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var mainImageView: UIImageView = {
        
        let imageV = UIImageView(image: UIImage(named: "MemoImage"))
        imageV.contentMode = .center
        return imageV
    }()
    
    private lazy var mainTodoButton: UIButton = {
        
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .systemYellow
        bt.layer.cornerRadius = 5
        bt.clipsToBounds = true
        bt.setTitle("할 일 보기", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        bt.frame.size.height = 48
        //bt.addTarget(self, action: #selector(todoButtonTapped()), for: .touchUpInside)
        return bt
    }()
    
    private lazy var mainCompleteButton: UIButton = {
        
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .orange
        bt.layer.cornerRadius = 5
        bt.clipsToBounds = true
        bt.setTitle("완료한 일 보기", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 20)
//        bt.frame.size.height = 48
        //bt.addTarget(self, action: #selector(completeButtonTapped()), for: .touchUpInside)
        return bt
    }()
    
    lazy var mainStackView: UIStackView = {
        
        let st = UIStackView(arrangedSubviews: [mainImageView, mainTodoButton, mainCompleteButton])
        st.spacing = 15
        st.axis = .vertical
        st.alignment = .fill
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainStackView)
        
        makeUI()
    }
    
    func makeUI() {
        
        view.backgroundColor = .systemGray6
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainTodoButton.translatesAutoresizingMaskIntoConstraints = false
        mainCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            mainTodoButton.heightAnchor.constraint(equalToConstant: 60),
            
            mainCompleteButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc func todoButtonTapped() {
        // 버튼 1이 눌렸을 때 수행할 동작
    }
    
    @objc func completeButtonTapped() {
        // 버튼 2가 눌렸을 때 수행할 동작
    }
}


