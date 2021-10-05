//
//  GuestViewProtocol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 02.06.2021.
//

protocol GuestViewProtocol: AnyObject {
    func set(presenter: GuestPresenterProtocol)
    func show(message: String)
}

