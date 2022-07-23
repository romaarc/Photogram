//
//  FBPostService.swift
//  Photogram
//
//  Created by Roman Gorshkov on 10.06.2021.
//

import Foundation
import RxSwift

protocol FBPostServiceProtocol {
    var trigger: PublishSubject<TriggerEvent> { get }
    func getPost(completion: @escaping (_ posts: [Post], _ error: Error?) -> Void)
    func create(post: Post, completion: @escaping (_ error: Error?) -> Void)
}

final class FBPostService: FBPostServiceProtocol {
    private(set) var trigger: PublishSubject<TriggerEvent> = PublishSubject<TriggerEvent>()
    private var provider: FBPostProviderProtocol!
    private var storageService: FBStorageServiceProtocol!
    
    init(provider: FBPostProviderProtocol, storageService: FBStorageServiceProtocol) {
        self.provider = provider
        self.storageService = storageService
    }

    func getPost(completion: @escaping ([Post], Error?) -> Void) {
        provider.getCollection { collection, error in
            completion(collection, error)
        }
    }

    func create(post: Post, completion: @escaping (Error?) -> Void) {
        if let error = validate(post: post).first {
            return completion(error)
        }
        
        guard let imgData = post.image else { return completion(Post.ValidationError.imageEmpty) }
        imgData.fullResolutionImageData { data in
            guard let imgData = data else { return }
            self.storageService.create(data: imgData) { result in
                switch result {
                case .success(let name):
                    var post = post
                    post.imageName = name
                    post.imageData = imgData
                    self.provider.create(post: post) { error in
                        self.trigger.onNext(.saved)
                        completion(error)
                    }
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
    
    private func validate(post: Post) -> [Post.ValidationError] {
        var errors = [Post.ValidationError]()
        if post.title.isEmpty {
            errors.append(Post.ValidationError.titleEmpty)
        }
        if nil == post.image {
            errors.append(Post.ValidationError.imageEmpty)
        }
        if nil == post.userId {
            errors.append(Post.ValidationError.userIdEmpty)
        }
        return errors
    }
}
