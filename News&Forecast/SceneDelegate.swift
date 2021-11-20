//
//  SceneDelegate.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 01.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light

        let assemblyBuilder = AssemblyModuleBuilder()
        let router = Router(window: window, assemblyBuilder: assemblyBuilder)
        NotificationDelegate.shared.router = router
        
        let loadingVC = assemblyBuilder.createLoadingScreenModule(router: router)
        if let notification = connectionOptions.notificationResponse {
            if let module = notification.notification.request.content.userInfo["module"] as? String {
                router.initialModule = module
                router.showInitialViewController()
            }
        }
        
        window?.rootViewController = loadingVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) {
            result,error in
            guard result else {return}
            let content = UNMutableNotificationContent()
            content.title = "We miss you!"
            content.body = "Come back and check forecast in your location..."
            content.badge = 1
            content.sound = .default
            content.userInfo = [
                "module": NotificationDelegate.mapForecastModule,
                "reason": "5days_withoutUser",
            ]

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
            let request = UNNotificationRequest(identifier: "5days_withoutUser", content: content, trigger: trigger)
            notificationCenter.add(request) { error_ in
                print(error_?.localizedDescription ?? "")
            }
        }
        
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

    }


}

