//
//  HomePresenter.swift
//  Photogram
//
//  Created by Roman Gorshkov on 10.06.2021.
//

import Foundation
import RxSwift
import ImageSource

final class HomePresenter {
    private weak var view: HomeViewProtocol?
    private var navigator: HomeNavigator!
    private var postService: FBPostServiceProtocol!
    private var userService: FBUserServiceProtocol!
    private let disposeBag = DisposeBag()
    
    init(navigator: HomeNavigator, postService: FBPostServiceProtocol, userService: FBUserServiceProtocol) {
        self.navigator = navigator
        self.postService = postService
        self.userService = userService
    }
}

extension HomePresenter {
    private func handle(error: Error) {
        view?.show(message: error.localizedDescription)
    }
    
    private func subscribe() {
        postService.trigger.subscribe(onNext: { event in
            self.updateView()
        })
        .disposed(by: disposeBag)
    }

    private func updateView() {
        postService.getPost {[weak self] posts, error in
            guard let self = self else { return }
            guard nil == error else { self.handle(error: error!); return }
            self.view?.update(collection: posts)
        }
            
    }
}

//MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func attach(view: HomeViewProtocol) {
        self.view = view
    }
    
    func viewisReady() {
        subscribe()
        updateView()
    }
    
    func singOut() {
        userService.signOut()
        // iOS13 or later
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            let rootAppService = RootApplicationService()
            rootAppService.reloadStartScreen { vc in
                sceneDelegate.window!.rootViewController = vc
            }
        }
    }
    
    func pickImage() {
        navigator.navigate(to: .showPicker(completion: { [weak self] items in
            guard let item = items.first else { return }
            self?.navigator.navigate(to: .createPost(imgItem: item))
        }))
    }
    
    func refresh() {
        updateView()
    }
    
    func profile() {
        navigator.navigate(to: .profile)
    }
}
