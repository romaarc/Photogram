//
//  HomePresenterProcol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 30.12.2021.
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
