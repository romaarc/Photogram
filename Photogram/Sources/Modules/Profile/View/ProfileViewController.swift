//
//  ProfileViewController.swift
//  Photogram
//
//  Created by Roman Gorshkov on 16.06.2021.
//

import UIKit

final class ProfileViewController: BaseViewController {
    private var presenter: ProfilePresenterProtocol?
    
    //MARK: - Life cycle
    override func loadView() {
        view = ProfileView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewIsReady()
    }
    
    //MARK: - Private
    internal override func setupUI() {
        super.setupUI()
        navigationItem.title = "profile".localized.firstUppercased
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func set(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
}

extension ProfileViewController: ProfileViewDelegate {}

