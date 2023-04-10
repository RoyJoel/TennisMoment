//
//  TMSys.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation
import TABAnimated

class TMSys {
    static let shard = TMSys()
    private init() {}

    func initWindow() -> UIWindow {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        window.backgroundColor = .white
        window.overrideUserInterfaceStyle = initStyle()
        window.rootViewController = initRootViewController()
        window.makeKeyAndVisible()
        return window
    }

    func initRootViewController() -> UIViewController {
        let isNotFirstDownload = UserDefaults.standard.bool(forKey: TMUDKeys.isNotFirstDownload.rawValue)
        if !isNotFirstDownload {
            DispatchQueue.main.async {
                UserDefaults.standard.set(true, forKey: TMUDKeys.isNotFirstDownload.rawValue)
            }
            return TMSignInViewController()
        } else {
            return TabViewController()
        }
    }

    func initStyle() -> UIUserInterfaceStyle {
        guard let appearance = UserDefaults.standard.string(forKey: "AppleAppearance") else {
            // 如果没有设置外观，则默认使用浅色模式。
            return .unspecified
        }
        let appearanceType = AppearanceSetting(userDisplayName: appearance)
        // 根据用户设置的外观来设置应用程序的外观。
        if appearanceType == .Dark {
            return .dark
        } else if appearanceType == .Light {
            return .light
        } else {
            return .unspecified
        }
    }

    func auth() {
        if let token = UserDefaults.standard.string(forKey: TMUDKeys.JSONWebToken.rawValue) {
            print("token is \(token)")
            TMUser.auth(token: token) { userLoginName, userPassword, error in
                guard error == nil else {
                    if let window = UIApplication.shared.windows.first {
                        let signInVC = TMSignInViewController()
                        window.rootViewController = signInVC
                        let toastView = UILabel()
                        toastView.text = "The login information has expired\n please log in again"
                        toastView.numberOfLines = 2
                        toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                        toastView.backgroundColor = UIColor(named: "ComponentBackground")
                        toastView.textAlignment = .center
                        toastView.setCorner(radii: 15)
                        (window.rootViewController as? TMSignInViewController)?.contentOverlayView?.showToast(toastView, duration: 1, point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)) { _ in
                        }
                    }
                    return
                }
                guard let userLoginName = userLoginName else {
                    return
                }
                guard let userPassword = userPassword else {
                    return
                }
                TMUser.user.loginName = userLoginName
                TMUser.user.password = userPassword
                TMUser.signIn { token, error in
                    guard error == nil else {
                        if let window = UIApplication.shared.windows.first {
                            let toastView = UILabel()
                            toastView.text = "No such loginname or password"
                            toastView.numberOfLines = 2
                            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                            toastView.backgroundColor = UIColor(named: "ComponentBackground")
                            toastView.textAlignment = .center
                            toastView.setCorner(radii: 15)
                            (window.rootViewController as? TMSignInViewController)?.contentOverlayView?.showToast(toastView, duration: 1, point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)) { _ in
                            }
                        }
                        return
                    }
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = TabViewController()
                    }
                    UserDefaults.standard.set(token, forKey: TMUDKeys.JSONWebToken.rawValue)
                }
            }
        } else {
            if let window = UIApplication.shared.windows.first {
                let signInVC = TMSignInViewController()
                window.rootViewController = signInVC
            }
        }
    }
}
