//
//  FBUserService.swift
//  Photogram
//
//  Created by Roman Gorshkov on 31.05.2021.
//

import Foundation
import Firebase
import RxSwift

//MARK: - Auth state
enum AuthStatus {
    case guest, authorized
}
//MARK: -  FBUserServiceProtocol
protocol FBUserServiceProtocol {
    var trigger: PublishSubject<(AuthStatus, Error?)> { get }
    static var currentUser: User? { get }
    static var isFirstLaunch: Bool { get set }
    func signIn(email: String, password: String)
    func signUp(email: String, password: String)
    func signOut()
}

final class FBUserService: FBUserServiceProtocol {
    //MARK: -  Firebase variables
    private let fbAuth = Auth.auth()
    static var currentUser: User? {
        var user = User()
        guard let userFb = Auth.auth().currentUser else { return nil }
        user.id = userFb.uid
        user.name = userFb.displayName
        return user
    }
    static var isFirstLaunch: Bool {
        get {
            return !UserDefaults.standard.bool(forKey: "isNotFirstLaunch")
        }
        set {
            UserDefaults.standard.set(!newValue, forKey: "isNotFirstLaunch")
        }
    }
    //MARK: - RxSwift variables
    private(set) var trigger: PublishSubject<(AuthStatus, Error?)> = PublishSubject<(AuthStatus, Error?)>()
    
    //MARK: - Firebase sign methods
    func signIn(email: String, password: String) {
        fbAuth.signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }
            if let error = error {
                self.trigger.onNext((.guest, error))
            } else {
                switch authResult {
                case .some:
                    self.trigger.onNext((.authorized, error))
                default:
                    break
                }
            }
        }
    }
    
    func signUp(email: String, password: String) {
        fbAuth.createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }
            if let error = error {
                self.trigger.onNext((.guest, error))
            } else {
                switch authResult {
                case .some:
                    self.trigger.onNext((.authorized, error))
                default:
                    break
                }
            }
        }
    }
    
    func signOut() {
        do {
            try fbAuth.signOut()
        } catch let error as NSError {
            debugPrint("Error signing out: %@", error.localizedDescription)
        }
    }
    
}
