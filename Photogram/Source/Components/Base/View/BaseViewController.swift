//
//  BaseViewController.swift
//  Photogram
//
//  Created by Roman Gorshkov on 09.06.2021.
//

import UIKit.UIViewController

public class BaseViewController: UIViewController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

// ------ setup ui -------
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .SLBlack
        self.setupUI()
    }

    internal func setupUI() {}
}
