//
//  ServicesAssembly.swift
//  Photogram
//
//  Created by Roman Gorshkov on 31.05.2021.
//

import Swinject

final class ServicesAssembly: Assembly {}

extension ServicesAssembly {
    func assemble(container: Container) {
        container.register(FBUserServiceProtocol.self) { _ in
            FBUserService()
        }
        container.register(FBStorageServiceProtocol.self) { resolver in
            FBStorageService(storageProvider: resolver.resolve(FBStorageProviderProtocol.self)!)
        }
        container.register(FBPostServiceProtocol.self) { resolver in
            FBPostService(provider: resolver.resolve(FBPostProviderProtocol.self)!,
                          storageService: resolver.resolve(FBStorageServiceProtocol.self)!)
        }.inObjectScope(.container)
    }
}
