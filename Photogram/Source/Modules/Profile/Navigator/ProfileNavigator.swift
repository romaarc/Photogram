//
//  ProfileNavigator.swift
//  Photogram
//
//  Created by Roman Gorshkov on 16.06.2021.
//

import UIKit
import Swinject

class ProfileNavigator: Navigator {
    
    var resolver: Resolver!
    
    internal weak var sourceViewController: UIViewController?
    
    enum Destination {
        case someDestination
    }
    
    // MARK: - Initializer
    init(sourceViewController: UIViewController?) {
        self.sourceViewController = sourceViewController
    }
    
    // MARK: - Navigator
    func navigate(to destination: ProfileNavigator.Destination) {
        if let destinationViewController = makeViewController(for: destination) {
            if let navVC = sourceViewController?.navigationController {
                navVC.pushViewController(destinationViewController, animated: true)
            }
        }
    }
    
    // MARK: - Private
    internal func makeViewController(for destination: Destination) -> UIViewController? {
        switch destination {
        case .someDestination:
//            return resolver.resolve(SomeViewProtocol.self) as? SomeViewController
            return nil
        }
    }

}
