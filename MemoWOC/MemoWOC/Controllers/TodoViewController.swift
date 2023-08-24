//
//  TodoViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/23.
//

import UIKit

class TodoViewController: UIViewController {
    
    var memoList: [Memo] = []
    
    let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        setConstraints()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = addButton
        
        tableView.reloadData()
        loadMemoList()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MemoCell.self, forCellReuseIdentifier: "MemoCell")
        
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func addButtonTapped() {
        showAlertToAddMemo()
    }

    func showAlertToAddMemo() {
        let alertController = UIAlertController(title: "메모 추가", message: "새로운 메모를 입력하세요", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "메모 내용"
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default) { _ in
            if let memoText = alertController.textFields?.first?.text {
                self.addMemoToList(memoText)
                self.saveMemoList()
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func addMemoToList(_ memoText: String) {
        let newMemo = Memo(content: memoText, isCompleted: false, category: "")
        memoList.append(newMemo)
        tableView.reloadData()
        saveMemoList()
    }

    // UserDefaults에 메모 리스트 저장
    func saveMemoList() {
        var memoDictList: [[String: Any]] = []
        
        for memo in memoList {
            let memoDict: [String: Any] = [
                "content": memo.content,
                "isCompleted": memo.isCompleted,
                "category": memo.category
            ]
            memoDictList.append(memoDict)
        }
        
        UserDefaults.standard.set(memoDictList, forKey: "MemoListKey")
    }

    // UserDefaults에서 메모 리스트 불러오기
    func loadMemoList() {
        if let savedMemoList = UserDefaults.standard.array(forKey: "MemoListKey") as? [[String: Any]] {
            memoList = savedMemoList.compactMap { dict in
                return Memo(
                    content: dict["content"] as? String ?? "",
                    isCompleted: dict["isCompleted"] as? Bool ?? false,
                    category: dict["category"] as? String ?? ""
                )
            }
        }
    }
}

extension TodoViewController: UITableViewDelegate {
    
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        configureCell(cell, at: indexPath)
        return cell
    }

    func configureCell(_ cell: MemoCell, at indexPath: IndexPath) {
        cell.memoLabel.text = memoList[indexPath.row].content
    }
}


