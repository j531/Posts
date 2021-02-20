//
//  AppDelegate.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import TinyConstraints
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Public properties

    var window: UIWindow?

    // MARK: Private properties

    private let disposeBag = DisposeBag()

    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        debugPrintIfNeeded()
        clearDataIfNeeded()
        setupWindow()

        return true
    }

    // MARK: Setup

    private func setupWindow() {
        let viewController = PostsModule.build().viewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }

    // MARK: Helpers

    private func clearDataIfNeeded() {
        Realm.removeDefault()
    }

    private func debugPrintIfNeeded() {
        #if DEBUG
        printRealmFilePath()
        #endif
    }

    private func printRealmFilePath() {
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "Can't get Realm URL"
        print("Realm URL:", realmURL)
    }
}
