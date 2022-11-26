//
//  UsersPresenter.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation

private extension String {
    static let defaultError = "Произошла ошибка"
}

protocol IUsersPresenter: AnyObject {
    func viewDidLoad()
    func getItem(for index: Int) -> User
    var numberOfRows: Int { get }
}

class UsersPresenter {
    private let service: IWorkshopService
    private let dataSource: IUserViewDataSource
    weak var view: IUsersView?
    
    var numberOfRows: Int {
        dataSource.itemsCount
    }
    
    init(
        service: IWorkshopService,
        dataSource: IUserViewDataSource
    ) {
        self.service = service
        self.dataSource = dataSource
    }
}

// MARK: - IUsersPresenter

extension UsersPresenter: IUsersPresenter {
    func viewDidLoad() {
        view?.startLoader()
        service.loadUsers { [weak self] result in
            switch result {
            case let .success(users):
                self?.dataSource.save(users)
            case let .failure(error):
                if let serviceError = error as? WorkshopServiceError {
                    DispatchQueue.main.async {
                        self?.view?.showErrorAlert(serviceError.rawValue)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.view?.showErrorAlert(.defaultError)
                    }
                }
            }
            DispatchQueue.main.async {
                self?.view?.stopLoader()
            }
        }
    }
    
    func getItem(for index: Int) -> User {
        dataSource.getUser(at: index)
    }
}
