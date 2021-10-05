//
//  Date+Extension.swift
//  Photogram
//
//  Created by Roman Gorshkov on 01.06.2021.
//

import Foundation

extension Date {
    public var dd．MM．yy: String {
        return DateFormatter.dd．MM．yy.string(from: self)
    }

    public var hh．mm: String {
        return DateFormatter.hh．mm.string(from: self)
    }
}

