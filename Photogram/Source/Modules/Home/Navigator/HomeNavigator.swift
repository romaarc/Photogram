//
//  HomeNavigator.swift
//  Photogram
//
//  Created by Roman Gorshkov on 15.06.2021.
//

import UIKit
import Swinject
import ImageSource
import Paparazzo

class HomeNavigator: Navigator {
    private var resolver: Resolver!
    var sourceViewController: UIViewController?
    
    enum Destination {
        case createPost(imgItem: MediaPickerItem)
        case showPicker(completion: (_ items: [MediaPickerItem]) -> Void)
        case profile
    }
    
    // MARK: - Initializer
    init(sourceViewController: UIViewController?, resolver: Resolver) {
        self.sourceViewController = sourceViewController
        self.resolver = resolver
    }
    
    // MARK: - Navigator
    func navigate(to destination: HomeNavigator.Destination) {
        if let destinationVC = makeViewController(for: destination) {
            switch destination {
            case .showPicker:
                sourceViewController?.present(destinationVC, animated: true, completion: nil)
            default:
                if let navVC = sourceViewController?.navigationController {
                    navVC.pushViewController(destinationVC, animated: true)
                }
            }
        }
    }
    
    // MARK: - Private
    func makeViewController(for destination: Destination) -> UIViewController? {
        switch destination {
        case .createPost(let item):
            if let vc = resolver.resolve(CreatePostViewProtocol.self) as? CreatePostViewController {
                vc.presenter?.set(imageSource: item.image)
                return vc
            }
        case .showPicker(let completion):
            var theme = PaparazzoUITheme()
            theme.photoLibraryCollectionBackgroundColor = .SLBlackTwo
            let vc = PaparazzoFacade.paparazzoViewController(
                theme: theme,
                parameters: MediaPickerData(
                    items: [],
                    maxItemsCount: 1
                ),
                onFinish: { items in
                    completion(items)
                }
            )
            return vc
        case .profile:
           if let vc = resolver.resolve(ProfileViewProtocol.self) as? ProfileViewController {
                return vc
            }
        }
        return nil
    }
    
}
