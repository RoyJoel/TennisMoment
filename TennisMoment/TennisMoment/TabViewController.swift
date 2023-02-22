//
//  ViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/21.
//

import SnapKit
import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .gray
        tabBar.tintColor = UIColor(named: "Tennis")
        tabBar.unselectedItemTintColor = .white
        tabBar.setCorner(radii: 30)

        addViewController()
    }

    override func viewDidLayoutSubviews() {
        var frame = tabBar.frame
        frame.size.width = view.frame.size.width - 24
        frame.origin.x = 12
        frame.origin.y = view.frame.size.height - frame.size.height - 18
        tabBar.frame = frame
    }

    private func addViewController() {
        setChildViewController(HomeViewController(), "Home", "tennisball.fill")
        setChildViewController(RecordViewController(), "Rankings", "trophy.fill")
        setChildViewController(AccountViewController(), "Me", "figure.tennis")
    }

    private func setChildViewController(_ childViewController: UIViewController, _ itemName: String, _ itemImage: String) {
        childViewController.title = itemName
        childViewController.tabBarItem.title = itemName
        childViewController.tabBarItem.image = UIImage(systemName: itemImage)

        let nav = UINavigationController(rootViewController: childViewController)
        addChild(nav)
    }
}
