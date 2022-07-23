//
//  MPRoundedButton.swift
//  Photogram
//
//  Created by Roman Gorshkov on 07.06.2021.
//

import UIKit.UIButton

final class MPRoundedButton: UIButton {
    convenience init(radius: CGFloat, backgroundColor: UIColor, textColor: UIColor) {
        self.init()
        layer.cornerRadius = radius
        clipsToBounds = true
        self.setBackgroundImage(UIImage(color: backgroundColor), for: .normal)
        self.setBackgroundImage(UIImage(color: .gray), for: .disabled)
        setTitleColor(textColor, for: .normal)
    }
}
