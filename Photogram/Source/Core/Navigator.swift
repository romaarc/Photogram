//
//  Navigator.swift
//  Photogram
//
//  Created by Roman Gorshkov on 01.06.2021.
//

import UIKit

public protocol Navigator {
    associatedtype Destination
    var sourceViewController: UIViewController? {get set}
    func navigate(to destination: Destination)
    func close()
    func closeModal()
    func navigateBack()
    func showModal(destination: Destination)
    func makeViewController(for destination: Destination) -> UIViewController?
}

extension Navigator {
    public func close() {}
    
    public func navigateBack() {
        self.sourceViewController?.navigationController?.popViewController(animated: true)
    }
    
    public func closeModal() {
        self.sourceViewController?.dismiss(animated: true, completion: nil)
    }
    
    public func showModal(destination: Destination) {
        if let vc = makeViewController(for: destination) {
            showModal(controller: vc)
        }
    }
    
    private func showModal(controller: UIViewController) {
        self.sourceViewController?.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}
