//
//  HomeAssembly.swift
//  Photogram
//
//  Created by Roman Gorshkov on 15.06.2021.
//

import Swinject

final class HomeAssembly: Assembly {}

extension HomeAssembly {
    func assemble(container: Container) {
        container.register(HomeViewProtocol.self) { _ in
            HomeViewController()
        }.initCompleted { (resolver: Resolver, view: HomeViewProtocol) in
            guard let presenter = resolver.resolve(HomePresenterProtocol.self, argument: view) as? HomePresenter else { return }
            presenter.attach(view: view)
            view.set(presenter: presenter)
        }
        
        container.register(HomeNavigator.self) { (resolver, view: HomeViewProtocol) in
            HomeNavigator(sourceViewController: view as? HomeViewController, resolver: resolver)
        }
        
        container.register(HomePresenterProtocol.self) { (resolver, view: HomeViewProtocol) in
            HomePresenter(navigator: resolver.resolve(HomeNavigator.self, argument: view)!,
                          postService: resolver.resolve(FBPostServiceProtocol.self)!,
                          userService: resolver.resolve(FBUserServiceProtocol.self)!)
        }
    }
}
