//
//  RootApplicationService.swift
//  Photogram
//
//  Created by Roman Gorshkov on 08.06.2021.
//

import Foundation
import Swinject
import UIKit.UIViewController

final class RootApplicationService {
    //MARK: - Assembly
    private let assembler = Assembler([])
    private let assemblies: [Assembly] = [
        ServicesAssembly(),
        ProvidersAssembly(),
        GuestAssembly(),
        HomeAssembly(),
        CreatePostAssembly(),
        ProfileAssembly()
    ]
    //MARK: - Private
    public func assemblyProject() {
        assembler.apply(assemblies: assemblies)
    }
    
    public func reloadStartScreen(completion: @escaping (_ T: UIViewController?) -> Void) {
        DispatchQueue.main.async {
            //FBUserService().signOut()
            if let currentUser = FBUserService.currentUser {
                if currentUser.isGuest ||
                FBUserService.isFirstLaunch {
                    guard let vc = self.load(moduleType: .guest) else { return }
                    completion(vc)
                } else {
                    guard let vc = self.load(moduleType: .home) else { return }
                    completion(vc)
                }
            } else {
                guard let vc = self.load(moduleType: .guest) else { return }
                completion(vc)
            }
        }
    }
    
    private enum LoadingModuleType {
        case guest, home
    }
    
    private func load(moduleType: LoadingModuleType) -> UIViewController? {
        var rootVC = UIViewController()
        rootVC.view.backgroundColor = .SLBlack
        switch moduleType {
        case .home:
            if let vc = assembler.resolver.resolve(HomeViewProtocol.self) as? HomeViewController {
                let navigation = UINavigationController(rootViewController: vc)
                navigation.navigationBar.tintColor = .white
                navigation.navigationBar.barTintColor = .SLBlackTwo
                navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                rootVC = navigation
                return rootVC
            }
        case .guest:
            if let vc = assembler.resolver.resolve(GuestViewProtocol.self) as? GuestViewController {
                FBUserService.isFirstLaunch = false
                rootVC = vc
                return rootVC
            }
        }
        return nil
    }
}
