//
//  HomeViewProtocol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 30.12.2021.
//

import Foundation
protocol HomeViewProtocol: BaseViewProtocol {
    func set(presenter: HomePresenterProtocol)
    func update(collection: [Post])
}
