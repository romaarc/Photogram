//
//  GuestNavigator.swift
//  Photogram
//
//  Created by Roman Gorshkov on 08.06.2021.
//

import UIKit
import Swinject

class GuestNavigator: Navigator {
    var resolver: Resolver!

    enum Destination {
        case someDestination
    }
  
    internal weak var sourceViewController: UIViewController?

    // MARK: - Initializer
    init(sourceViewController: UIViewController?) {
        self.sourceViewController = sourceViewController
    }

    // MARK: - Navigator
    func navigate(to destination: GuestNavigator.Destination) {
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
            //return resolver.resolve(SomeViewType.self) as? SomeViewController
            return nil
        }
    }
}
