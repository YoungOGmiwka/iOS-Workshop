//
//  SceneDelegate.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let rootNavigationController = UINavigationController()
    
    private var usersAssembly: IUsersAssembly { UsersAssembly() }
    
    private lazy var router: IRouter = {
        Router(transitionHandler: rootNavigationController, usersAssembly: usersAssembly)
    }()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootNavigationController
        router.showUsersScreen()
        self.window = window
        window.makeKeyAndVisible()
    }
}

