//
//  DetailViewController.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/25.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    var memo: Memo
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.detailTextView.text = memo.content
    }
    
    init(memo: Memo) {
        self.memo = memo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
