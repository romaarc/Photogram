//
//  CreatePostPresenterProtocol.swift
//  Photogram
//
//  Created by Roman Gorshkov on 17.06.2021.
//

import ImageSource

protocol CreatePostPresenterProtocol {
    func viewIsReady()
    func set(imageSource: ImageSource)
    func done(title: String)
}
