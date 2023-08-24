//
//  MemoCell.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/24.
//

import UIKit

class MemoCell: UITableViewCell {
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(memoLabel)
        
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            memoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            memoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            memoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
