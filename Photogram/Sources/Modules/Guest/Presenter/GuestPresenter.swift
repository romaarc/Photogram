//
//  GuestPresenter.swift
//  Photogram
//
//  Created by Roman Gorshkov on 07.06.2021.
//

import RxSwift
import UIKit

final class GuestPresenter {
    private weak var view: GuestViewProtocol?
    var navigator: GuestNavigator!
    private let disposeBag = DisposeBag()
    private let fbUserService: FBUserServiceProtocol!
    
    init(fbUserService: FBUserServiceProtocol) {
        self.fbUserService = fbUserService
    }
}

extension GuestPresenter {
    private func subscribe() {
        fbUserService.trigger.subscribe(onNext:  { [weak self] status, error in
            guard let self = self else { return }
            guard nil == error else { self.handle(error: error!); return }
            switch status {
            case .guest:
                print("🥶 guest")
            case .authorized:
                self.navigator.navigate(to: .home)
            }
        
        })
        .disposed(by: disposeBag)
    }
    
    private func handle(error: Error) {
        view?.show(message: error.localizedDescription)
    }
}

//MARK: - GuestPresenterProtocol
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
