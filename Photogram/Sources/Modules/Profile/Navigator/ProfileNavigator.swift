//
//  ProfileNavigator.swift
//  Photogram
//
//  Created by Roman Gorshkov on 16.06.2021.
//

import UIKit
import Swinject

final class ProfileNavigator: Navigator {
    var resolver: Resolver!
    weak var sourceViewController: UIViewController?
    
    enum Destination {
        case someDestination
    }
    
    init(sourceViewController: UIViewController?) {
        self.sourceViewController = sourceViewController
    }
}

extension ProfileNavigator {
    func navigate(to destination: ProfileNavigator.Destination) {
        if let destinationViewController = makeViewController(for: destination) {
            if let navVC = sourceViewController?.navigationController {
                navVC.pushViewController(destinationViewController, animated: true)
            }
        }
    }
    
    internal func makeViewController(for destination: Destination) -> UIViewController? {
        switch destination {
        case .someDestination:
            //            return resolver.resolve(SomeViewProtocol.self) as? SomeViewController
            return nil
        }
    }
}
