//
//  MainTabContainer.swift
//  Remember
//
//  Created by 박창규 on 12/3/24.
//

import UIKit

import SearchFeatureInterface
import BookmarkFeatureInterface

import Swinject

final class MainTabContainer {
    
    static func start(
        window: UIWindow?,
        container: Swinject.Container
    ) {
        let searchVC = container.resolve(SearchFeatureOutput.self)!
            .viewController
        
        let bookmarkVC = container.resolve(BookmarkOutput.self)!
            .viewController
        
        let mainController = MainTabViewController(
            reactor: MainTabViewReactor(),
            searchVC: searchVC,
            bookmarkVC: bookmarkVC
        )
        
        let navigationController = UINavigationController(
            rootViewController: mainController
        )
        
        navigationController.navigationBar.prefersLargeTitles = true
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
