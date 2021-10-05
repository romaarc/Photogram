//
//  ProvidersAssembly.swift
//  Photogram
//
//  Created by Roman Gorshkov on 15.06.2021.
//

import Swinject

class ProvidersAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FBPostProviderProtocol.self) {_ in
            FBPostProvider()
        }
        container.register(FBStorageProviderProtocol.self) {_ in
            FBStorageProvider()
        }
    }
}
