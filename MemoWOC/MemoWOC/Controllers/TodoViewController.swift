//
//  TodoViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/23.
//

import UIKit

class TodoViewController: UIViewController {
    
    var memoList: [Memo] = []
    var currentID: Int = 0
    var highestMemoID: Int = 0
    
    let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memoList = MemoManager.loadMemoList()
        tableView.reloadData()
        
        if let maxID = memoList.map({ $0.id }).max() {
            highestMemoID = maxID + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        setupTableView()
        setConstraints()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .systemGray6
        tableView.register(MemoCell.self, forCellReuseIdentifier: "MemoCell")
        
        view.addSubview(tableView)
        
        memoList = MemoManager.loadMemoList()
        tableView.reloadData()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        addButton.tintColor = .systemYellow
        
        navigationItem.rightBarButtonItem = addButton
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil)
        
        backBarButtonItem.tintColor = .systemYellow
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @objc func addButtonTapped() {
        showActionSheetToAddMemo()
    }
    
    func showActionSheetToAddMemo() {
        let actionSheet = UIAlertController(title: "메모 추가", message: "메모의 중요도를 선택 해주세요", preferredStyle: .actionSheet)
        
        for category in MemoCategory.allCases {
            let categoryAction = UIAlertAction(title: category.rawValue, style: .default) { _ in
                self.showAlertToAddMemo(withCategory: category)
            }
            actionSheet.addAction(categoryAction)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func showAlertToAddMemo(withCategory category: MemoCategory) {
        let alertController = UIAlertController(title: "메모 추가", message: "새로운 메모를 입력하세요", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "메모 내용"
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default) { _ in
            if let memoText = alertController.textFields?.first?.text {
                self.addMemoToList(memoText, withCategory: category)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func addMemoToList(_ memoText: String, withCategory category: MemoCategory) {
        let newMemo = Memo(id: highestMemoID, content: memoText, isCompleted: false, category: category.rawValue)
        
        memoList.append(newMemo)
        highestMemoID += 1
        tableView.reloadData()
        MemoManager.saveMemoList(memoList)
        print("id: \(newMemo.id)")
    }
}

extension TodoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = MemoCategory.allCases[indexPath.section]
        let memosInCategory = memoList.filter { $0.category == category.rawValue }
        
        let selectedMemo = memosInCategory[indexPath.row]
        
        let detailViewController = DetailViewController()
        
        detailViewController.memo = selectedMemo
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlertToDeleteMemo(at: indexPath)
        }
    }
    
    func showAlertToDeleteMemo(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: "메모 삭제", message: "이 메모를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deleteMemo(at: indexPath)
            MemoManager.saveMemoList(self.memoList)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteMemo(at indexPath: IndexPath) {
        let category = MemoCategory.allCases[indexPath.section]
        let memosInCategory = memoList.filter { $0.category == category.rawValue }
        
        if let originalIndex = memoList.firstIndex(where: { $0.id == memosInCategory[indexPath.row].id }) {
            memoList.remove(at: originalIndex)
        }
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension TodoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MemoCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MemoCategory.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = MemoCategory.allCases[section]
        let memosInCategory = memoList.filter { $0.category == category.rawValue }
        return memosInCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        
        let category = MemoCategory.allCases[indexPath.section]
        let memosInCategory = memoList.filter { $0.category == category.rawValue }
        
        configureCell(cell, withMemo: memosInCategory[indexPath.row])
        
        return cell
    }
    
    func configureCell(_ cell: MemoCell, withMemo memo: Memo) {
        cell.memoLabel.text = memo.content
        
        let switchControl = UISwitch()
        switchControl.onTintColor = .systemOrange
        switchControl.isOn = memo.isCompleted
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchControl
        
        updateTextAppearance(cell, withText: memo.content, isSwitchOn: memo.isCompleted)
    }
    
    func updateTextAppearance(_ cell: MemoCell, withText text: String, isSwitchOn: Bool) {
        let attributeString = NSMutableAttributedString(string: text)
        
        if isSwitchOn {
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        } else {
            attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        }
        
        cell.memoLabel.attributedText = attributeString
    }

    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if let cell = sender.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let category = MemoCategory.allCases[indexPath.section]
            var memosInCategory = memoList.filter { $0.category == category.rawValue }
            memosInCategory[indexPath.row].isCompleted = sender.isOn
            
            if let originalIndex = memoList.firstIndex(where: { $0.id == memosInCategory[indexPath.row].id }) {
                memoList[originalIndex].isCompleted = sender.isOn
            }
            
            updateTextAppearance(cell as! MemoCell, withText: memosInCategory[indexPath.row].content, isSwitchOn: sender.isOn)
            MemoManager.saveMemoList(memoList)
        }
    }

}
