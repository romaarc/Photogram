//
//  GuestView.swift
//  Photogram
//
//  Created by Roman Gorshkov on 02.06.2021.
//

import UIKit
import EasyPeasy
import RxSwift
import RxCocoa

protocol GuestViewDelegate: AnyObject {
    func signUpEvent(email: String, password: String)
    func signInEvent(email: String, password: String)
}

class GuestView: BaseView { //UIView
    private weak var delegate: GuestViewDelegate?
    //MARK: - Subviews
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let logo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let signInButton: UIButton = {
        let btn = MPRoundedButton(radius: 5, backgroundColor: .SLDullYellow, textColor: .black)
        btn.setTitle("sign in".localized.firstUppercased, for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    private let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("sign up".localized.firstUppercased, for: .normal)
        btn.setTitleColor(.SLDullYellow, for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        btn.isEnabled = false
        return btn
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SLWhite
        label.font = .systemFont(ofSize: 15)
        label.text = "or".localized
        label.textAlignment = .center
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField(padding: 10)
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.attributedPlaceholder = "email".localized.firstUppercased.attributed(attributes: Settings.shared.placeholderAttrs)
        field.backgroundColor = .SLBlackTwo
        field.layer.cornerRadius = 6
        field.clipsToBounds = true
        field.keyboardAppearance = .dark
        field.textColor = .SLWhite
        field.returnKeyType = .next
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField(padding: 10)
        field.isSecureTextEntry = true
        field.backgroundColor = .SLBlackTwo
        field.attributedPlaceholder = "password".localized.firstUppercased.attributed(attributes: Settings.shared.placeholderAttrs)
        field.layer.cornerRadius = 6
        field.clipsToBounds = true
        field.keyboardAppearance = .dark
        field.textColor = .SLWhite
        field.returnKeyType = .done
        return field
    }()
    
    // MARK: - Initialization
    init(delegate: GuestViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UI
    private func setupUI() {
        self.backgroundColor = .SLBlack
        setupScrollView()
        setupLogo()
        setupSignInForm()
        setupSignInButton()
        setupOrLabel()
        setupSignUpButton()
        setupTapGesture()
        bindUI()
    }
    
    //MARK: - RxSwift
    private func bindUI() {
        let isValidPassword = passwordField.rx.text.orEmpty
            .map { $0.count > Settings.shared.passwordMinLength }
            .distinctUntilChanged()
        
        let isValidEmail = emailField.rx.text.orEmpty
            .map { $0.isValidEmail }
            .distinctUntilChanged()
        
        Observable.combineLatest(isValidEmail, isValidPassword) { $0 && $1 }
            .subscribe(onNext: { isValidCredentials in
                self.signInButton.isEnabled = isValidCredentials
                self.signUpButton.isEnabled = isValidCredentials
            }).disposed(by: disposeBag)
        
        emailField.rx.controlEvent([.editingDidEndOnExit])
            .subscribe(onNext: { _ in
                self.passwordField.becomeFirstResponder()
            }).disposed(by: disposeBag)
        passwordField.rx.controlEvent([.editingDidEndOnExit])
            .subscribe(onNext: { _ in
                self.signInAction()
            }).disposed(by: disposeBag)
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.easy.layout(Edges())
        scrollView.addSubview(contentView)
        contentView.easy.layout(Edges(), Width().like(self), Height().like(self).with(.low))
    }
    
    private func setupLogo() {
        contentView.addSubview(logo)
        logo.easy.layout(CenterX(), Width(50), Height(50), Top(20).to(self.safeAreaLayoutGuide, .top))
    }
    
    //MARK: SignInForm
    private func setupSignInForm() {
        setupEmailField()
        setupPasswordField()
    }
    
    private func setupEmailField() {
        contentView.addSubview(emailField)
        emailField.easy.layout(Left(40), Right(40), Top(20).to(logo, .bottom), Height(50))
    }
    
    private func setupPasswordField() {
        contentView.addSubview(passwordField)
        passwordField.easy.layout(Left(40), Right(40), Top(16).to(emailField, .bottom), Height(50))
    }
    
    private func setupSignInButton() {
        contentView.addSubview(signInButton)
        signInButton.easy.layout(Top(20).to(passwordField, .bottom),
        Height(47),
        Left(40).to(self, .left),
        Right(40).to(self, .right))
        addTargetSignInButton()
    }
    
    private func setupSignUpButton() {
        contentView.addSubview(signUpButton)
        signUpButton.easy.layout(Top().to(orLabel, .bottom),
        Height(47),
        Left(40).to(self, .left),
        Right(40).to(self, .right))
        addTargetSignUpButton()
    }
    
    private func setupOrLabel() {
        contentView.addSubview(orLabel)
        orLabel.easy.layout(Top(20).to(signInButton,.bottom),
                            Height(40),
                            Left(40).to(self, .left),
                            Right(40).to(self, .right)
        )
    }
    
    
    private func setupTapGesture() {
        let taper = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        addGestureRecognizer(taper)
    }
    // MARK: - Actions on buttons
    @objc private func hideKeyboardAction() {
        endEditing(true)
    }
    
    @objc private func signUpAction() {
        guard let email = emailField.text,
            let password = passwordField.text else { return }
        delegate?.signUpEvent(email: email, password: password)
    }
    
    @objc private func signInAction() {
        guard let email = emailField.text,
            let password = passwordField.text else { return }
        delegate?.signInEvent(email: email, password: password)
    }
    
    private func addTargetSignInButton() {
        signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
    }
    
    private func addTargetSignUpButton() {
        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
    }
}
