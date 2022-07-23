//
//  BaseTableViewCell.swift
//  Photogram
//
//  Created by Roman Gorshkov on 09.06.2021.
//

import UIKit.UITableViewCell

class BaseTableViewCell: UITableViewCell, Configurable {
    var value: Any?
    
    class var identifier: String {
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    override final func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
