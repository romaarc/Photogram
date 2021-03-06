//
//  HomeView.swift
//  Photogram
//
//  Created by Roman Gorshkov on 09.06.2021.
//

import UIKit
import EasyPeasy
import RxSwift
import RxCocoa

protocol HomeViewDelegate: AnyObject {
    func refresh()
}

final class HomeView: BaseView {
    private weak var delegate: HomeViewDelegate?
    private var data = PublishSubject<[Post]>()
    
    // MARK: - Subviews
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.tableFooterView = UIView()
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        return table
    }()
    
    private let refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .SLWarmGrey
       return refreshControl
    }()
    
    //MARK: - Inits
    init(delegate: HomeViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Methods
    func prepareView() {
        addSubview(tableView)
        tableView.easy.layout(Edges(), Bottom(10))
        bindTable()
        refresher.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    func update(collection: [Post]) {
        data.onNext(collection)
        refresher.endRefreshing()
    }
    
    // MARK: - Private
    private func bindTable() {
        data.bind(to: tableView.rx.items(cellIdentifier: PostCell.identifier, cellType: PostCell.self)) {_, post, cell in
            cell.value = post
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @objc private func refreshAction() {
        delegate?.refresh()
    }
}
