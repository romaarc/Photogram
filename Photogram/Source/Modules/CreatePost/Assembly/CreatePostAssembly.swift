//
//  CreatePostAssembly.swift
//  Photogram
//
//  Created by Roman Gorshkov on 17.06.2021.
//

import Swinject

class CreatePostAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CreatePostViewProtocol.self) { _ in
            CreatePostViewController()
        }.initCompleted { (resolver: Resolver, view: CreatePostViewProtocol) in
            if let presenter = resolver.resolve(CreatePostPresenterProtocol.self, argument: view) as? CreatePostPresenter {
                if let navigator = resolver.resolve(CreatePostNavigator.self, argument: view) {
                    navigator.resolver = resolver
                    presenter.navigator = navigator
                }
                view.set(presenter: presenter)
            }
        }

        container.register(CreatePostNavigator.self) { (_, view: CreatePostViewProtocol) in
            CreatePostNavigator(sourceViewController: view as? CreatePostViewController)
        }
        
        container.register(CreatePostPresenterProtocol.self) { (resolver, view: CreatePostViewProtocol) in
            CreatePostPresenter(view: view, postService: resolver.resolve(FBPostServiceProtocol.self)!)
        }
    }
}
