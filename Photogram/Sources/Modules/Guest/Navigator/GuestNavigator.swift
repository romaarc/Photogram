//
//  GuestNavigator.swift
//  Photogram
//
//  Created by Roman Gorshkov on 08.06.2021.
//

import UIKit
import Swinject

final class GuestNavigator: Navigator {
    var resolver: Resolver!

    enum Destination {
        case home
    }
  
    weak var sourceViewController: UIViewController?

    init(sourceViewController: UIViewController?) {
        self.sourceViewController = sourceViewController
    }
}

extension GuestNavigator {
    func navigate(to destination: GuestNavigator.Destination) {
        if let destinationVC = makeViewController(for: destination) {
            let navigation = UINavigationController(rootViewController: destinationVC)
            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.tintColor = .white
            navigation.navigationBar.barTintColor = .SLBlackTwo
            navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            sourceViewController?.present(navigation, animated: true)
        }
    }
    
    internal func makeViewController(for destination: Destination) -> UIViewController? {
        switch destination {
        case .home:
            if let vc = resolver.resolve(HomeViewProtocol.self) as? HomeViewController {
                 return vc
             }
            return nil
        }
    }
}
