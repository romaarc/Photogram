//
//  CreatePostViewController.swift
//  Photogram
//
//  Created by Roman Gorshkov on 17.06.2021.
//

import UIKit
import Toast
import ImageSource
import SVProgressHUD

class CreatePostViewController: BaseViewController {
    var presenter: CreatePostPresenterProtocol?
    private var titleText: String = "" {
        didSet {
            navigationItem.rightBarButtonItem?.isEnabled = titleText.count > 1
        }
    }
    
    //MARK: - Life Cycles
    override func loadView() {
        view = CreatePostView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewIsReady()
    }
    
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "create post".localized.firstUppercased
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "done".localized.firstUppercased,
            style: .done,
            target: self,
            action: #selector(doneAction))
        navigationItem.rightBarButtonItem?.isEnabled = false
        (view as? CreatePostView)?.prepareView()
    }
    
    //TODO: ERROR
    //MARK: - Actions
    @objc private func doneAction() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        //SVProgressHUD.show()
        (self.view as? CreatePostView)?.freeze()
        self.presenter?.done(title: self.titleText)
    }
}

extension CreatePostViewController: CreatePostViewProtocol {
    func set(presenter: CreatePostPresenterProtocol) {
        self.presenter = presenter
    }
    
    func set(image: ImageSource) {
        (view as? CreatePostView)?.set(image: image)
    }
    
    func show(message: String) {
        view.makeToast(message, duration: 3.0, position: .top)
    }
    
    func unfreeze() {
        //SVProgressHUD.dismiss()
    }
}

extension CreatePostViewController: CreatePostViewDelegate {
    func titleUpdated(text: String) {
        titleText = text
    }
}

