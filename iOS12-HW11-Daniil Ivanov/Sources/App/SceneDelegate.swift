//
//  SceneDelegate.swift
//  iOS12-HW11-Daniil Ivanov
//
//  Created by Daniil (work) on 22.01.2024.
//

import Foundation
import UIKit

final class SceneDelegate: UISceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: ViewController())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
