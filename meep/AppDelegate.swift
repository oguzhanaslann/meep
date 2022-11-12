//
//  AppDelegate.swift
//  meep
//
//  Created by Oğuzhan Aslan on 12.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        print("didReceive")
    }
}


//func requestNotificationAuthorization() {
//    let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
//
//    self.userNotificationCenter.requestAuthorization(options: authOptions) { isGranted, error in
//        if let error = error {
//              print("Error: ", error)
//        }
//    }
//}

//        self.userNotificationCenter.delegate = self
//      self.requestNotificationAuthorization()
//func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//    print("userNotificationCenter 2nd")
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
////            if self.sentTime < 5 {
////                self.sentTime += 1
////                self.sendNotification()
////            }
//    }
//
//    completionHandler([.alert, .badge, .sound])
//}
//class RandomNotificationSender {
//
//    func createNotification(userNotificationCenter : UNUserNotificationCenter) {
//
//        let notificationContent = UNMutableNotificationContent()
//
//        // Add the content to the notification content
//        notificationContent.title = "Test"
//        notificationContent.body = "Test body"
//        notificationContent.badge = NSNumber(value: 3)
//
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        let request = UNNotificationRequest(
//            identifier: "testNotification",
//            content: notificationContent,
//            trigger: trigger
//        )
//
//        userNotificationCenter.add(request) { (error) in
//            if let error = error {
//                print("Notification Error: ", error)
//            }
//        }
//
//    }
//}
