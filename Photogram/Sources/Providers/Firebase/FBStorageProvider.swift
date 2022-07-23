//
//  StorageProvider.swift
//  Photogram
//
//  Created by Roman Gorshkov on 10.06.2021.
//

import Foundation
import FirebaseStorage

protocol FBStorageProviderProtocol: BaseProviderProtocol {
    func create(data: Data, completion: @escaping (Result<String?, StorageError>) -> Void)
}

final class FBStorageProvider {
    var collectionName = "images"
}

//MARK: - FBStorageProviderProtocol
extension FBStorageProvider: FBStorageProviderProtocol {
    func create(data: Data, completion: @escaping (Result<String?, StorageError>) -> Void) {
        let name = UUID().uuidString
        let reference = Storage.storage().reference().child("\(collectionName)/\(name)")
        reference.putData(data, metadata: nil) { (metadata, error) in
            if error != nil {
                completion(.failure(.error))
            } else {
                completion(.success(name))
            }
        }
    }
}
