//
//  GuestPresenterProtocol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 02.06.2021.
//

protocol GuestPresenterProtocol {
    func attach(view: GuestViewProtocol)
    func viewIsReady()
    func signUp(email: String, password: String)
    func signIn(email: String, password: String)
}
