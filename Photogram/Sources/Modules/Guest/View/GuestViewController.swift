//
//  GuestViewController.swift
//  Photogram
//
//  Created by Roman Gorshkov on 02.06.2021.
//

import UIKit
import Toast

final class GuestViewController: UIViewController {
    private var presenter: GuestPresenterProtocol?
    
    override func loadView() {
        view = GuestView(delegate: self)
    }
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewIsReady()
    }
}

extension GuestViewController: GuestViewProtocol {
    func set(presenter: GuestPresenterProtocol) {
        self.presenter = presenter
    }
    
    func show(message: String) {
        view.makeToast(message, duration: 3.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
    }
}

extension GuestViewController: GuestViewDelegate {
    func signUpEvent(email: String, password: String) {
        presenter?.signUp(email: email, password: password)
    }
    
    func signInEvent(email: String, password: String) {
        presenter?.signIn(email: email, password: password)
    }
}
