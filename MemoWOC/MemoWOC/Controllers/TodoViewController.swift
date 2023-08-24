//
//  TodoViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/23.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memoList: [String] = ["메모 1", "메모 2", "메모 3"]
    
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
        navigationItem.rightBarButtonItem = addButton
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
        // 추가 버튼을 눌렀을 때 실행되는 코드
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
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func addMemoToList(_ memo: String) {
        memoList.append(memo)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        configureCell(cell, at: indexPath)
        return cell
    }

    func configureCell(_ cell: MemoCell, at indexPath: IndexPath) {
        cell.memoLabel.text = memoList[indexPath.row]
    }
}


