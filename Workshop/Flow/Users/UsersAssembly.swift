//
//  UsersAssembly.swift
//  Workshop
//
//  Created by Артем Шарапов on 04.12.2022.
//

import Foundation
import UIKit

protocol IUsersAssembly: AnyObject {
    func makeUsersScreen(router: IRouter) -> UIViewController
    func makeProfileScreen(userId: Int, router: IRouter) -> UIViewController
    func makePostsScreen(userId: Int) -> UIViewController
}

final class UsersAssembly: IUsersAssembly {
    func makeUsersScreen(router: IRouter) -> UIViewController {
        let service = WorkshopService()
        let alertFactory = UsersAlertViewFactory()
        let presenter = UsersPresenter(
            service: service,
            dataSource: UsersViewDataSource.shared,
            router: router
        )
        let viewController = UsersViewController(
            alertFactory: alertFactory,
            output: presenter
        )
        presenter.view = viewController
        return viewController
    }
    
    func makeProfileScreen(userId: Int, router: IRouter) -> UIViewController {
        let service = WorkshopService()
        let alertFactory = UsersAlertViewFactory()
        
        let presenter = ProfilePresenter(
            userId: userId,
            dataSource: UsersViewDataSource.shared,
            service: service,
            router: router
        )
        
        let viewController = ProfileViewController(output: presenter, alertFactory: alertFactory)
        presenter.view = viewController
        return viewController
    }
    
    func makePostsScreen(userId: Int) -> UIViewController {
        let presenter = PostsPresenter(dataSource: UsersViewDataSource.shared)
        let viewController = PostsViewController(output: presenter)
        return viewController
    }
}
