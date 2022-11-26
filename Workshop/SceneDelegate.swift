//
//  SceneDelegate.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let alertFactory = UsersAlertViewFactory()
        let service = WorkshopService()
        let dataSource = UsersViewDataSource()
        let presenter = UsersPresenter(
            service: service,
            dataSource: dataSource
        )
        let usersViewController = UsersViewController(alertFactory: alertFactory, output: presenter)
        presenter.view = usersViewController
        let rootNavigationController = UINavigationController(rootViewController: usersViewController)
        window.rootViewController = rootNavigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

