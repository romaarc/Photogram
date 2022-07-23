//
//  UITextField+Extension.swift
//  Photogram
//
//  Created by Roman Gorshkov on 01.06.2021.
//

import UIKit.UITextField

extension UITextField {
    convenience init(padding: Int) {
        self.init()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: padding))
        leftView = paddingView
        leftViewMode = .always
    }
}
