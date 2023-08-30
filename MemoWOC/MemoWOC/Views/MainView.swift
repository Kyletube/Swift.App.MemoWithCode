//
//  MainView.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/24.
//

import UIKit

class MainView: UIView {
    
    // 메인화면 이미지
    let mainImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    // 할 일 보기 버튼
    let mainTodoButton: UIButton = {
        $0.backgroundColor = .systemYellow
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.setTitle("할 일 보기", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        // $0.addTarget(self, action: #selector(todoButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
     // 완료한 일 보기 버튼
    let mainCompleteButton: UIButton = {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.setTitle("완료한 일 보기", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        bt.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    // 위의 3가지를 묶은 스택뷰
    private let mainStackView: UIStackView = {
        $0.spacing = 20
        $0.axis = .vertical
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    let showDogButton: UIButton = {
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.setTitle("강아지 보기", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return $0
    }(UIButton(type: .custom))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    func setUI() {
        backgroundColor = .systemGray6
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainTodoButton.translatesAutoresizingMaskIntoConstraints = false
        mainCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        showDogButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainImageView)
        mainStackView.addArrangedSubview(mainTodoButton)
        mainStackView.addArrangedSubview(mainCompleteButton)
        mainStackView.addArrangedSubview(showDogButton)
    }
    
    // UI제약 설정
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            mainTodoButton.heightAnchor.constraint(equalToConstant: 45),
            mainTodoButton.widthAnchor.constraint(equalToConstant: 200),
            
            mainCompleteButton.heightAnchor.constraint(equalToConstant: 45),
            mainCompleteButton.widthAnchor.constraint(equalToConstant: 200),
            
            showDogButton.heightAnchor.constraint(equalToConstant: 45),
            showDogButton.widthAnchor.constraint(equalToConstant: 200),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}
