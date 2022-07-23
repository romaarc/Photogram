//
//  GuestAssembly.swift
//  Photogram
//
//  Created by Roman Gorshkov on 08.06.2021.
//

import Swinject

final class GuestAssembly: Assembly {}

extension GuestAssembly {
    func assemble(container: Container) {
        container.register(GuestViewProtocol.self) { _ in
            GuestViewController()
        }.initCompleted { (resolver, view) in
            if let presenter = resolver.resolve(GuestPresenterProtocol.self) as? GuestPresenter {
                if let navigator = resolver.resolve(GuestNavigator.self, argument: view) {
                    navigator.resolver = resolver
                    presenter.navigator = navigator
                }
                presenter.attach(view: view)
                view.set(presenter: presenter)
            }
        }
        
        container.register(GuestNavigator.self) { (_, view: GuestViewProtocol) in
            GuestNavigator(sourceViewController: view as? GuestViewController)
        }
        
        container.register(GuestPresenterProtocol.self) { resolver in
            GuestPresenter(fbUserService: resolver.resolve(FBUserServiceProtocol.self)!)
        }
    }
}
