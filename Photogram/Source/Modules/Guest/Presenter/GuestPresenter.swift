//
//  GuestPresenter.swift
//  Photogram
//
//  Created by Roman Gorshkov on 07.06.2021.
//

import RxSwift
import UIKit.UIApplication

class GuestPresenter {
    //MARK: - Variables
    private weak var view: GuestViewProtocol?
    var navigator: GuestNavigator!
    private let disposeBag = DisposeBag()
    private let fbUserService: FBUserServiceProtocol!
    
    init(fbUserService: FBUserServiceProtocol) {
        self.fbUserService = fbUserService
    }
        
    // MARK: - Private funcs
    private func subscribe() {
        fbUserService.trigger.subscribe(onNext:  { [weak self] status, error in
            guard let self = self else { return }
            guard nil == error else { self.handle(error: error!); return }
            switch status {
            case .guest:
                print("🥶 guest")
            case .authorized:
                // iOS13 or later
                if #available(iOS 13.0, *) {
                    let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                    let rootAppService = RootApplicationService()
                    rootAppService.reloadStartScreen { vc in
                        sceneDelegate.window!.rootViewController = vc
                    }
                }
            }
        
        })
        .disposed(by: disposeBag)

    }
    
    private func handle(error: Error) {
        view?.show(message: error.localizedDescription)
    }
}

extension GuestPresenter: GuestPresenterProtocol {
    func attach(view: GuestViewProtocol) {
        self.view = view
    }
    
    func viewIsReady() {
        subscribe()
    }
    
    func signUp(email: String, password: String) {
        fbUserService.signUp(email: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        fbUserService.signIn(email: email, password: password)
    }
    
    
}
