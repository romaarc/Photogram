//
//  HomeViewController.swift
//  Photogram
//
//  Created by Roman Gorshkov on 09.06.2021.
//

import UIKit
import Paparazzo
import ImageSource
import Toast

final class HomeViewController: BaseViewController {
    private var presenter: HomePresenterProtocol?
    
    //MARK: - Life cycle
    override func loadView() {
        view = HomeView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (view as? HomeView)?.prepareView()
        setupNavigationBar()
        presenter?.viewisReady()
    }
    
    // MARK: - Private
    private func setupNavigationBar() {
        navigationItem.title = "home".localized.firstUppercased
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "profile"), style: .plain, target: self, action: #selector(profileAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    private func showPicker() {
        presenter?.pickImage()
    }
    
    // MARK: - Actions
    @objc private func profileAction() {
        presenter?.profile()
    }
    
    @objc private func addAction() {
        showPicker()
    }
    
    //этот метод нигде не использовался
    @objc private func signoutAction() {
        let alert = UIAlertController(title: "sign_out".localized.firstUppercased, message: "sign_out_confirmation".localized.firstUppercased,
                                                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "sign_out".localized.firstUppercased, style: .destructive, handler: { _ in
            //self.presenter?.signOut()
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized.firstUppercased, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewProtocol {
    func set(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
    
    func update(collection: [Post]) {
        (view as? HomeView)?.update(collection: collection)
    }
    
    func show(message: String) {
        view.makeToast(message, duration: 3.0, position: .top, style: ToastStyle.init())
    }
}

extension HomeViewController: HomeViewDelegate {
    func refresh() {
        presenter?.refresh()
    }
}
