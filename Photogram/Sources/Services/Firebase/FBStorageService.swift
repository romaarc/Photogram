//
//  FBStorageService.swift
//  Photogram
//
//  Created by Roman Gorshkov on 15.06.2021.
//

import Foundation
import Firebase

protocol FBStorageServiceProtocol {
    func create(data: Data, completion: @escaping (Result<String?, StorageError>) -> Void)
}

final class FBStorageService {
    private var provider: FBStorageProviderProtocol!
    
    init(storageProvider: FBStorageProviderProtocol) {
        self.provider = storageProvider
    }
}

//MARK: - FBStorageServiceProtocol
extension FBStorageService: FBStorageServiceProtocol {
    func create(data: Data, completion: @escaping (Result<String?, StorageError>) -> Void) {
        provider.create(data: data) { result in
            switch result {
            case .failure(_):
                completion(result)
            case .success(_):
                completion(result)
            }
        }
    }
}
