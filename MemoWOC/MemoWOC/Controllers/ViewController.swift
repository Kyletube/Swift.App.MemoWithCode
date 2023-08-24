//
//  ViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    // 메인화면 이미지
    private let mainImageView: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "MemoImage"))
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    // 할 일 보기 버튼
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
    
     // 완료한 일 보기 버튼
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
    
    // 위의 3가지를 묶은 스택뷰
    private let mainStackView: UIStackView = {
        let st = UIStackView()
        st.spacing = 20
        st.axis = .vertical
        st.alignment = .center
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
    }
    
    // UI 설정
    func setUI() {
        view.backgroundColor = .systemGray6
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainTodoButton.translatesAutoresizingMaskIntoConstraints = false
        mainCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainImageView)
        mainStackView.addArrangedSubview(mainTodoButton)
        mainStackView.addArrangedSubview(mainCompleteButton)
    }
    
    // UI제약 설정
    func setConstraints() {
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
    
    // 할 일 보기 버튼 눌렀을때 작동하는 함수
    @objc func todoButtonTapped() {
        let todoViewController = TodoViewController()
        let navigationController = UINavigationController(rootViewController: todoViewController)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func completeButtonTapped() {
        
    }
}


