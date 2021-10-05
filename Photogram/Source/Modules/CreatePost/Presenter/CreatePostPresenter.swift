//
//  CreatePostPresenter.swift
//  Photogram
//
//  Created by Roman Gorshkov on 17.06.2021.
//

import Foundation
import ImageSource

class CreatePostPresenter {
    private weak var view: CreatePostViewProtocol?
    var navigator: CreatePostNavigator!
    private var postService: FBPostServiceProtocol!
    private var post = Post()

    init(view: CreatePostViewProtocol, postService: FBPostServiceProtocol) {
        self.view = view
        self.postService = postService
        post.userId = FBUserService.currentUser?.id
    }
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
    func viewIsReady() {
        if let image = post.image {
            view?.set(image: image)
        }
    }

    func set(imageSource: ImageSource) {
        post.image = imageSource
    }

    func done(title: String) {
        post.title = title
        postService.create(post: post) { [weak self] error in
            if let error = error {
                self?.view?.show(message: error.localizedDescription)
            } else {
                // success
                self?.view?.unfreeze()
                self?.navigator.navigateBack()
            }
        }
    }
}
