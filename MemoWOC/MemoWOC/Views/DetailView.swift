//
//  DetailView.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/25.
//

import UIKit

class DetailView: UIView {
    
    let detailContentLabel: UILabel = {
        $0.text = "내용"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textColor = .systemYellow
        return $0
    }(UILabel())
    
    let detailTextView: UITextView = {
        $0.font = .systemFont(ofSize: 16)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemYellow.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        return $0
    }(UITextView())
    
    let detailCategoryLabel: UILabel = {
        $0.text = "카테고리"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textColor = .systemOrange
        return $0
    }(UILabel())
    
    let detailCategoryButton: UIButton = {
        $0.backgroundColor = .systemOrange
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.setTitle("카테고리 선택", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       return $0
    }(UIButton())
    
    let detailTopStackView: UIStackView = {
        $0.spacing = 20
        $0.axis = .vertical
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    let detailBottomStackView: UIStackView = {
        $0.spacing = 20
        $0.axis = .vertical
        $0.alignment = .center
        return $0
    }(UIStackView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = .systemGray6
        
        detailContentLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        detailCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        detailCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        detailTopStackView.translatesAutoresizingMaskIntoConstraints = false
        detailBottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(detailTopStackView)
        detailTopStackView.addArrangedSubview(detailContentLabel)
        detailTopStackView.addArrangedSubview(detailTextView)
        
        addSubview(detailBottomStackView)
        detailBottomStackView.addArrangedSubview(detailCategoryLabel)
        detailBottomStackView.addArrangedSubview(detailCategoryButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            detailTopStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailTopStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            detailTopStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            
            detailTextView.leadingAnchor.constraint(equalTo: detailTopStackView.leadingAnchor),
            detailTextView.trailingAnchor.constraint(equalTo: detailTopStackView.trailingAnchor),
            detailTextView.heightAnchor.constraint(equalToConstant: 320),
            
            detailBottomStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailBottomStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            detailBottomStackView.topAnchor.constraint(equalTo: detailTopStackView.bottomAnchor, constant: 32),
            
            detailCategoryButton.widthAnchor.constraint(equalToConstant: 140),
            detailCategoryButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
