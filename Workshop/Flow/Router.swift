//
//  Router.swift
//  Workshop
//
//  Created by Артем Шарапов on 04.12.2022.
//

import Foundation
import UIKit

protocol IRouter: AnyObject {
    func showUsersScreen()
    func showProfile(userId: Int)
    func showPosts(userId: Int)
}

final class Router {
    private let transitionHandler: UINavigationController
    private let usersAssembly: IUsersAssembly
    
    init(transitionHandler: UINavigationController, usersAssembly: IUsersAssembly) {
        self.transitionHandler = transitionHandler
        self.usersAssembly = usersAssembly
    }
}

extension Router: IRouter {
    func showUsersScreen() {
        let viewController = usersAssembly.makeUsersScreen(router: self)
        transitionHandler.pushViewController(viewController, animated: true)
    }
    
    func showProfile(userId: Int) {
        let viewController = usersAssembly.makeProfileScreen(userId: userId, router: self)
        transitionHandler.pushViewController(viewController, animated: true)
    }
    
    func showPosts(userId: Int) {
        let viewController = usersAssembly.makePostsScreen(userId: userId)
        viewController.modalPresentationStyle = .formSheet
        viewController.isModalInPresentation = false
        transitionHandler.present(viewController, animated: true)
    }
}
