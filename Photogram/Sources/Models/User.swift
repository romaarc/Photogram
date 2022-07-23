//
//  User.swift
//  Photogram
//
//  Created by Roman Gorshkov on 31.05.2021.
//

import Foundation

struct User {
    var id: String?
    var name: String?
    var isGuest: Bool { nil == id }
}
