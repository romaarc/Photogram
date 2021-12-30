//
//  HomeViewProtocol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 09.06.2021.
//

import Foundation
protocol HomeViewProtocol: BaseViewProtocol{
    func set(presenter: HomePresenterProtocol)
    func update(collection: [Post])
}
