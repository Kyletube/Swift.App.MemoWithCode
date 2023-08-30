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
        if let memo = memo {
            detailView.detailTextView.text = memo.content
        }
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
}
