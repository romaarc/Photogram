//
//  Configurable.swift
//  Photogram
//
//  Created by Roman Gorshkov on 09.06.2021.
//

protocol Configurable {
    var value: Any? { get set }
    func configure()
}
