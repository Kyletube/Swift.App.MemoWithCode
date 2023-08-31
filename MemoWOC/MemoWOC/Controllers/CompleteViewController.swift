//
//  CompleteViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/24.
//

import UIKit

class CompleteViewController: UIViewController {
    
    var completeMemoList: [Memo] = []
    
    let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setConstraints()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .systemGray6
        tableView.register(MemoCell.self, forCellReuseIdentifier: "MemoCell")
        
        view.addSubview(tableView)
        
        completeMemoList = MemoManager.loadMemoList().filter { $0.isCompleted }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CompleteViewController: UITableViewDelegate {
    
}

extension CompleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeMemoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        configureCell(cell, at: indexPath)
        
        let memo = completeMemoList[indexPath.row]
        updateTextAppearance(cell, withText: memo.content, isSwitchOn: memo.isCompleted)
        
        return cell
    }
    
    func configureCell(_ cell: MemoCell, at indexPath: IndexPath) {
        let memo = completeMemoList[indexPath.row]
        cell.memoLabel.text = memo.content
        
        let switchControl = UISwitch()
        switchControl.onTintColor = .systemOrange
        switchControl.isOn = memo.isCompleted
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        switchControl.isEnabled = false
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
    }
}
