//
//  CreatePostNavigator.swift
//  Photogram
//
//  Created by Roman Gorshkov on 17.06.2021.
//

import UIKit.UIViewController
import Swinject

final class CreatePostNavigator: Navigator {
    var resolver: Resolver!
    weak var sourceViewController: UIViewController?

    enum Destination {
        case someDestination
    }

    init(sourceViewController: UIViewController?) {
        self.sourceViewController = sourceViewController
    }
}

extension CreatePostNavigator {
    func navigate(to destination: CreatePostNavigator.Destination) {
        if let destinationViewController = makeViewController(for: destination) {
            if let navVC = sourceViewController?.navigationController {
                navVC.pushViewController(destinationViewController, animated: true)
            }
        }
    }
    
    func makeViewController(for destination: Destination) -> UIViewController? {
        switch destination {
        case .someDestination:
//            return resolver.resolve(SomeViewProtocol.self) as? SomeViewController
            return nil
        }
    }
}
