//
//  Formatter+Extension.swift
//  Photogram
//
//  Created by Roman Gorshkov on 01.06.2021.
//

import Foundation

extension DateFormatter {
    static let dd．MM．yyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    static let dd．MM．yy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()

    static let hh．mm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
