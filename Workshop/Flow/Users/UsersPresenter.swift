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
    func didSelectUser(at index: Int)
    var numberOfRows: Int { get }
}

class UsersPresenter {
    private let service: IWorkshopService
    private let dataSource: IUserViewDataSource
    private let router: IRouter?
    weak var view: IUsersView?
    
    var numberOfRows: Int {
        dataSource.itemsCount
    }
    
    init(
        service: IWorkshopService,
        dataSource: IUserViewDataSource,
        router: IRouter?
    ) {
        self.service = service
        self.dataSource = dataSource
        self.router = router
    }
}

// MARK: - IUsersPresenter

extension UsersPresenter: IUsersPresenter {
    func viewDidLoad() {
        view?.startLoader()
        service.loadUsers { [weak self] result in
            switch result {
            case let .success(users):
                self?.dataSource.saveUsers(users)
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
    
    func didSelectUser(at index: Int) {
        router?.showProfile(userId: index)
    }
}
