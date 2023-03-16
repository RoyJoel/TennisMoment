//
//  TMTableView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/16.
//

import Foundation
import UIKit

class TMTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var config: TMTableViewConfig = TMTableViewConfig(cells: [], rowHeight: 0, rowNum: 0, rowNumWhenFold: 0, rowNumWhenUnfold: 0)
    public var originalBounds: CGRect = .init()

    public var originalPoint: CGPoint = .init()

    public var newBounds: CGRect = .init()

    public var newPoint: CGPoint = .init()

    public var scaleTimes: CGFloat = .init()

    public var duration: CFTimeInterval = 0

    public var toggle: Bool = false

    public func setup(_ originalBounds: CGRect, _ originalPoint: CGPoint, _ newBounds: CGRect, _ newPoint: CGPoint, _ duration: CFTimeInterval) {
        self.originalBounds = originalBounds
        self.originalPoint = originalPoint
        self.newBounds = newBounds
        self.newPoint = newPoint
        self.duration = duration
    }

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        dataSource = self
        delegate = self
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
        register(TMPopUpViewCell.self, forCellReuseIdentifier: "TMPopUpViewCell")
    }

    func setupEvent(config: TMTableViewConfig) {
        self.config = config
    }

    @objc func popoverView() {
        isScrollEnabled = true
        scaleTo(toggle)
    }

    @objc func dismissView() {
        isScrollEnabled = false
        scaleTo(toggle)
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        config.rowNum
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        30
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = config.cells[indexPath.row]
        return cell
    }

    open func scaleTo(_ isEnlarge: Bool) {
        if !isEnlarge {
            toggle.toggle()
            addAnimation(originalPoint, newPoint, duration, "position", completionHandler: {})
            addAnimation(originalBounds, newBounds, duration, "bounds", completionHandler: {})
            bounds = newBounds
            layer.position = newPoint
        } else {
            toggle.toggle()
            addAnimation(newBounds, originalBounds, duration, "bounds", completionHandler: {})
            addAnimation(newPoint, originalPoint, duration, "position", completionHandler: {})
            bounds = originalBounds
            layer.position = originalPoint
        }
    }

    open func scaleTo(_ isEnlarge: Bool, completionHandler: @escaping () -> Void) {
        if !isEnlarge {
            toggle.toggle()
            addAnimation(originalPoint, newPoint, duration, "position", completionHandler: {})
            addAnimation(originalBounds, newBounds, duration, "bounds", completionHandler: {
                completionHandler()
            })
            bounds = newBounds
            layer.position = newPoint
        } else {
            toggle.toggle()
            addAnimation(newBounds, originalBounds, duration, "bounds", completionHandler: {})
            addAnimation(newPoint, originalPoint, duration, "position", completionHandler: {
                completionHandler()
            })
            bounds = originalBounds
            layer.position = originalPoint
        }
    }
}

class TMTableViewConfig {
    var cells: [UITableViewCell]
    var rowHeight: CGFloat
    var rowNum: Int
    var rowNumWhenFold: Int
    var rowNumWhenUnfold: Int
    init(cells: [UITableViewCell], rowHeight: CGFloat, rowNum: Int, rowNumWhenFold: Int, rowNumWhenUnfold: Int) {
        self.cells = cells
        self.rowHeight = rowHeight
        self.rowNum = rowNum
        self.rowNumWhenFold = rowNumWhenFold
        self.rowNumWhenUnfold = rowNumWhenUnfold
    }
}
