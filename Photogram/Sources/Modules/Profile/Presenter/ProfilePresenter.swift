//
//  ProfilePresenter.swift
//  Photogram
//
//  Created by Roman Gorshkov on 16.06.2021.
//

final class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    var navigator: ProfileNavigator!
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func attach(view: ProfileViewProtocol) {
        self.view = view
    }

    func viewIsReady() {}
}
