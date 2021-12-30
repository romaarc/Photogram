//
//  HomePresenterProcol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 09.06.2021.
//

import Foundation

protocol HomePresenterProtocol {
    func attach(view: HomeViewProtocol)
    func viewisReady()
    func singOut()
    func pickImage()
    func refresh()
    func profile()
}
