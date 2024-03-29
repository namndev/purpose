//
//  AppDelegate.swift
//  eSurvey
//
//  Created by Nam Nguyen on 1/12/18.
//  Copyright © 2018 Unilever. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        UserDefaults.standard.set(["vi"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        do {
            Network.reachability = try Reachability(hostname: ISurveyApi.HOSTNAME)
            do { try Network.reachability?.start() } catch let error as Network.Error { print(error) } catch { print(error) }
        } catch {
            print(error)
        }
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert , .badge , .sound], categories: nil))
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
extension AppDelegate {
    class func sharedAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate;
    }
    func switchRootViewController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if animated {
            UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self.window!.rootViewController = controller
                UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if let completion = completion {
                    completion()
                }
            })
        } else {
            self.window!.rootViewController = controller
        }
    }
}

