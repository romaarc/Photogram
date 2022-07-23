//
//  ProfileAssembly.swift
//  Photogram
//
//  Created by Roman Gorshkov on 16.06.2021.
//

import Swinject

final class ProfileAssembly: Assembly {}

extension ProfileAssembly {
    func assemble(container: Container) {
        container.register(ProfileViewProtocol.self) { _ in
            ProfileViewController()
        }.initCompleted { resolver, view in
            if let presenter = resolver.resolve(ProfilePresenterProtocol.self) as? ProfilePresenter {
                if let navigator = resolver.resolve(ProfileNavigator.self, argument: view) {
                    navigator.resolver = resolver
                    presenter.navigator = navigator
                }
                presenter.attach(view: view)
                view.set(presenter: presenter)
            }
        }
        container.register(ProfileNavigator.self) { (_, view: ProfileViewProtocol) in
            ProfileNavigator(sourceViewController: view as? ProfileViewController)
        }
        
        container.register(ProfilePresenterProtocol.self) { _ in
            ProfilePresenter()
        }
    }
}
