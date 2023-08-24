//
//  MemoCell.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/24.
//

import UIKit

class MemoCell: UITableViewCell {
    
    let memoLabel: UILabel = {
        return $0
    }(UILabel())
    
    let completeSwitch: UISwitch = {
        $0.onTintColor = .systemOrange
        return $0
    }(UISwitch())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(memoLabel)
        contentView.addSubview(completeSwitch)
        
        memoLabel.translatesAutoresizingMaskIntoConstraints = false
        completeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            memoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            memoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            memoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            completeSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completeSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
