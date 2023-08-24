//
//  ViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAddTarget()
    }
    
    func setUpAddTarget() {
        mainView.mainTodoButton.addTarget(self, action: #selector(todoButtonTapped), for: .touchUpInside)
        mainView.mainCompleteButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    // 할 일 보기 버튼 눌렀을때 작동하는 함수
    @objc func todoButtonTapped() {
        let todoViewController = TodoViewController()
        navigationController?.pushViewController(todoViewController, animated: true)
    }

    
    @objc func completeButtonTapped() {
        
    }
}


