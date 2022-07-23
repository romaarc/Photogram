//
//  CreatePostViewProtocol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 17.06.2021.
//

import ImageSource

protocol CreatePostViewProtocol: AnyObject {
    func set(presenter: CreatePostPresenterProtocol)
    func set(image: ImageSource)
    func show(message: String)
    func unfreeze()
}
