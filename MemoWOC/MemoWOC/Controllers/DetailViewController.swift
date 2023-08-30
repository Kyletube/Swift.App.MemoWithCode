//
//  DetailViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/25.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    var memo: Memo?
    var todoViewController: TodoViewController?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAddTarget()
        
        if let memo = memo {
            detailView.detailTextView.text = memo.content
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateMemo()
        if let todoViewController = todoViewController {
            todoViewController.memoList = MemoManager.loadMemoList()
            todoViewController.tableView.reloadData()
        }
    }
    
    func updateMemo() {
        if var updatedMemo = memo, let updatedText = detailView.detailTextView.text {
            updatedMemo.content = updatedText
            MemoManager.updateMemo(updatedMemo)
            todoViewController?.memoList = MemoManager.loadMemoList()
            todoViewController?.tableView.reloadData()
        }
    }
    
    @objc func dismissKeyboard() {
        detailView.detailTextView.resignFirstResponder()
    }
    
    func setUpAddTarget() {
        detailView.detailCategoryButton1.addTarget(self, action: #selector(category1ButtonTapped), for: .touchUpInside)
        detailView.detailCategoryButton2.addTarget(self, action: #selector(category2ButtonTapped), for: .touchUpInside)
        detailView.detailCategoryButton3.addTarget(self, action: #selector(category3ButtonTapped), for: .touchUpInside)
    }
    
    @objc func category1ButtonTapped() {
        
    }
    
    @objc func category2ButtonTapped() {
        
    }
    
    @objc func category3ButtonTapped() {
        
    }
}
