//
//  ProfileView.swift
//  Photogram
//
//  Created by Roman Gorshkov on 16.06.2021.
//

import UIKit
import EasyPeasy
import RxSwift
import RxCocoa

protocol ProfileViewDelegate: AnyObject {}

final class ProfileView: BaseView {
    private var delegate: ProfileViewDelegate?
    
    //MARK: - Subviews
    private let avatarView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .SLWarmGrey
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = "username".localized.firstUppercased.attributed(attributes: [.foregroundColor: UIColor.SLWarmGrey,
                                                                                                                                                                                             .font: UIFont.systemFont(ofSize: 15)])
        field.backgroundColor = .SLBlackTwo
        field.layer.cornerRadius = 6
        field.clipsToBounds = true
        field.keyboardAppearance = .dark
        field.textColor = .SLWhite
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        field.leftView = paddingView
        field.leftViewMode = .always
        return field
    }()
    
    private let saveButton: UIButton = {
        let btn = MPRoundedButton(radius: 8, backgroundColor: .SLDullYellow, textColor: .SLBlackTwo)
        btn.setTitle("save".localized.firstUppercased, for: .normal)
        return btn
    }()
    
    // MARK: - Inits
    init(delegate: ProfileViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        prepareView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods

    private func prepareView() {
        [avatarView, nameField, saveButton].forEach { addSubview($0) }

        avatarView.easy.layout(Top(20).to(safeAreaLayoutGuide, .top), CenterX(), Width(*0.5).like(self, .width), Height().like(avatarView, .width))
        nameField.easy.layout(Top(20).to(avatarView, .bottom), Left(16), Right(26), Height(50))
        saveButton.easy.layout(Top(20).to(nameField, .bottom), Left(16), Right(16), Height(50))

        let taper = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(taper)

        saveButton.rx.tap.bind {
            debugPrint("????????????")
        }.disposed(by: disposeBag)
        nameField.becomeFirstResponder()
    }
    
    // MARK: - Private

    // MARK: - Actions

    @objc private func hideKeyboard() {
        endEditing(true)
    }
}
    
