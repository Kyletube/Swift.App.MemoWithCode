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
        
        setAddButton()
        setupTableView()
        setConstraints()
        
//        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil)
//        backBarButtonItem.tintColor = .systemYellow
//        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .systemGray6
        tableView.register(MemoCell.self, forCellReuseIdentifier: "MemoCell")
        
        view.addSubview(tableView)
        
        tableView.reloadData()
        loadMemoList()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = addButton
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
        MemoManager.saveMemoList(memoList)
    }
    
    // UserDefaults에서 메모 리스트 불러오기
    func loadMemoList() {
        memoList = MemoManager.loadMemoList()
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
        
        let memo = memoList[indexPath.row]
        updateTextAppearance(cell, withText: memo.content, isSwitchOn: memo.isCompleted)
        
        return cell
    }
    
    func configureCell(_ cell: MemoCell, at indexPath: IndexPath) {
        let memo = memoList[indexPath.row]
        cell.memoLabel.text = memo.content
        
        let switchControl = UISwitch()
        switchControl.onTintColor = .systemOrange
        switchControl.isOn = memo.isCompleted
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchControl
    }
    
    func updateTextAppearance(_ cell: UITableViewCell, withText text: String, isSwitchOn: Bool) {
        let attributeString = NSMutableAttributedString(string: text)
        
        if isSwitchOn {
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        } else {
            attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        }
        
        cell.textLabel?.attributedText = attributeString
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if let cell = sender.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            memoList[indexPath.row].isCompleted = sender.isOn
            updateTextAppearance(cell, withText: memoList[indexPath.row].content, isSwitchOn: sender.isOn)
            saveMemoList()
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}
