//
//  TMSignUpViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/2.
//

import Foundation
import TMComponent
import UIKit

class TMSignUpViewController: UIViewController {
    let gripConfig = gripConfigViewDataSource()
    let backhandConfig = backhandConfigViewDataSource()
    let configItems = ["Please enter a name for yourself", "Please choose a profile picture.", "What is your gender?", "What is your age?", "How many years have you been playing?", "What is your height in centimeters?", "What is your width in kilograms?", "What is your grip type?", "What is your backhand type?", "Please enter a account for yourself.", "Please enter a password for yourself."]
    var currentIndex = 0

    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressViewStyle = .default
        return view
    }()

    lazy var signInTitleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var nameTextField: TMTextField = {
        let label = TMTextField()
        return label
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var sexTextField: TMSelectionView = {
        let label = TMSelectionView()
        return label
    }()

    lazy var ageTextField: TMTextField = {
        let label = TMTextField()
        return label
    }()

    lazy var yearsPlayedTextField: TMTextField = {
        let label = TMTextField()
        return label
    }()

    lazy var heightTextField: TMTextField = {
        let label = TMTextField()
        return label
    }()

    lazy var widthTextField: TMTextField = {
        let label = TMTextField()
        return label
    }()

    lazy var gripTextField: TMPopUpView = {
        let label = TMPopUpView()
        return label
    }()

    lazy var backgroundTextField: TMPopUpView = {
        let label = TMPopUpView()
        return label
    }()

    lazy var accountTextField: TMTextField = {
        let label = TMTextField()
        return label
    }()

    lazy var passwordTextField: TMTextField = {
        let label = TMTextField()
        return label
    }()

    lazy var nextConfigBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    lazy var lastConfigBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(progressView)
        view.addSubview(signInTitleView)
        view.addSubview(nameTextField)
        view.addSubview(iconImageView)
        view.addSubview(sexTextField)
        view.addSubview(ageTextField)
        view.addSubview(yearsPlayedTextField)
        view.addSubview(heightTextField)
        view.addSubview(widthTextField)
        view.addSubview(accountTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nextConfigBtn)
        view.addSubview(lastConfigBtn)
        view.addSubview(gripTextField)
        view.addSubview(backgroundTextField)

        signInTitleView.isHidden = false
        nameTextField.isHidden = false
        iconImageView.isHidden = true
        sexTextField.isHidden = true
        ageTextField.isHidden = true
        yearsPlayedTextField.isHidden = true
        heightTextField.isHidden = true
        widthTextField.isHidden = true
        gripTextField.isHidden = true
        backgroundTextField.isHidden = true
        accountTextField.isHidden = true
        passwordTextField.isHidden = true

        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.width.equalToSuperview().offset(-88)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        signInTitleView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(88)
            make.left.equalToSuperview().offset(48)
            make.width.equalTo(388)
            make.height.equalTo(50)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(50)
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(288)
        }
        sexTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(88)
        }
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(50)
        }
        yearsPlayedTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(50)
        }
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(50)
        }
        widthTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(50)
        }
        gripTextField.frame = CGRect(x: 208, y: 294, width: 288, height: 44)
        backgroundTextField.frame = CGRect(x: 208, y: 294, width: 288, height: 44)
        accountTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(signInTitleView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(50)
        }
        nextConfigBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-88)
            make.centerX.equalToSuperview().offset(68)
            make.width.equalTo(88)
            make.height.equalTo(50)
        }

        lastConfigBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-88)
            make.centerX.equalToSuperview().offset(-68)
            make.width.equalTo(88)
            make.height.equalTo(50)
        }

        nameTextField.tag = 200
        iconImageView.tag = 201
        sexTextField.tag = 202
        ageTextField.tag = 203
        yearsPlayedTextField.tag = 204
        heightTextField.tag = 205
        widthTextField.tag = 206
        gripTextField.tag = 207
        backgroundTextField.tag = 208
        accountTextField.tag = 209
        passwordTextField.tag = 210

        progressView.setCorner(radii: 8)
        progressView.progress = 0
        progressView.progressTintColor = UIColor(named: "BackgroundGray") // 已有进度颜色
        progressView.trackTintColor = .gray
        signInTitleView.text = configItems[currentIndex]
        let nameConfig = TMTextFieldConfig(placeholderText: configItems[0])
        nameTextField.setup(with: nameConfig)
        iconImageView.image = UIImage(systemName: "camera")
        iconImageView.tintColor = UIColor(named: "ContentBackground")
        sexTextField.setupUI()
        sexTextField.setupEvent(config: TMServeViewConfig(selectedImage: "circle.fill", unSelectedImage: "circle", selectedTitle: "man", unselectedTitle: "woman"))
        let ageConfig = TMTextFieldConfig(placeholderText: configItems[3])
        ageTextField.setup(with: ageConfig)
        let yearsPlayedConfig = TMTextFieldConfig(placeholderText: configItems[4])
        yearsPlayedTextField.setup(with: yearsPlayedConfig)
        let heightConfig = TMTextFieldConfig(placeholderText: configItems[5])
        heightTextField.setup(with: heightConfig)
        let widthConfig = TMTextFieldConfig(placeholderText: configItems[6])
        widthTextField.setup(with: widthConfig)
        gripTextField.delegate = gripTextField
        gripTextField.dataSource = gripConfig
        gripTextField.setupUI()
        backgroundTextField.delegate = backgroundTextField
        backgroundTextField.dataSource = backhandConfig
        backgroundTextField.setupUI()
        let accountConfig = TMTextFieldConfig(placeholderText: configItems[9])
        accountTextField.setup(with: accountConfig)
        let passwordConfig = TMTextFieldConfig(placeholderText: configItems[10])
        passwordTextField.setup(with: passwordConfig)
        nextConfigBtn.setupUI()
        let nextBtnConfig = TMButtonConfig(title: "Next Step", action: #selector(stepForward), actionTarget: self)
        nextConfigBtn.setUp(with: nextBtnConfig)
        let lastBtnConfig = TMButtonConfig(title: "Last Step", action: #selector(stepBackward), actionTarget: self)
        lastConfigBtn.setUp(with: lastBtnConfig)
    }

    @objc func stepForward() {
        if currentIndex < configItems.count - 1 {
            currentIndex += 1
            progressView.setProgress(Float(currentIndex) / Float(configItems.count), animated: true)
            signInTitleView.text = configItems[currentIndex]
            view.viewWithTag(currentIndex + 199)?.isHidden = true
            view.viewWithTag(currentIndex + 200)?.isHidden = false
            if let thisView = view.viewWithTag(currentIndex + 200) as? TMPopUpView {
                view.bringSubviewToFront(thisView)
            }
        } else if currentIndex == configItems.count - 1 {
            TMUser.user.loginName = accountTextField.textField.text ?? ""
            TMUser.user.password = passwordTextField.textField.text ?? ""
            TMUser.user.name = nameTextField.textField.text ?? ""
//            TMUser.user.icon = iconImageView.image
            TMUser.user.sex = sexTextField.isLeft ? .Man : .Woman
            TMUser.user.age = Int(ageTextField.textField.text ?? "0") ?? 0
            TMUser.user.yearsPlayed = Int(yearsPlayedTextField.textField.text ?? "0") ?? 0
            TMUser.user.height = Float(Int(heightTextField.textField.text ?? "0") ?? 0)
            TMUser.user.width = Float(Int(widthTextField.textField.text ?? "0") ?? 0)
            TMUser.user.grip = gripConfig.gripConfig[gripTextField.selectedIndex?.row ?? 0]
            TMUser.user.backhand = backhandConfig.backhandConfig[backgroundTextField.selectedIndex?.row ?? 0]
            TMUser.user.points = 0
            TMUser.user.isAdult = (Int(ageTextField.textField.text ?? "0") ?? 0) > 18 ? true : false
            TMUser.signUp { token, error in
                guard error == nil else {
                    if self.view.window != nil {
                        let toastView = UILabel()
                        toastView.text = "login failed"
                        toastView.numberOfLines = 2
                        toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                        toastView.backgroundColor = UIColor(named: "ComponentBackground")
                        toastView.textAlignment = .center
                        toastView.setCorner(radii: 15)
                        self.view.showToast(toastView, duration: 1, point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)) { _ in
                        }
                    }
                    return
                }
                var loggedinUser = (UserDefaults.standard.array(forKey: TMUDKeys.loggedinUser.rawValue) as? [String]) ?? []
                loggedinUser.append(TMUser.user.loginName)
                UserDefaults.standard.set(loggedinUser, forKey: TMUDKeys.loggedinUser.rawValue)
                UserDefaults.standard.set(token, forKey: TMUDKeys.JSONWebToken.rawValue)
                // 登录成功后，跳转到下一个界面
                if let window = self.view.window {
                    let homeVC = TabViewController()
                    window.rootViewController = homeVC
                }
            }
        }
    }

    @objc func stepBackward() {
        if currentIndex > 0 {
            currentIndex -= 1
            progressView.setProgress(Float(currentIndex) / Float(configItems.count), animated: true)
            signInTitleView.text = configItems[currentIndex]
            view.viewWithTag(currentIndex + 199)?.isHidden = false
            view.viewWithTag(currentIndex + 200)?.isHidden = true
            if let thisView = view.viewWithTag(currentIndex + 200) as? TMPopUpView {
                view.bringSubviewToFront(thisView)
            }
        } else if currentIndex == 0 {
            dismiss(animated: true)
        }
    }
}

class gripConfigViewDataSource: NSObject, UITableViewDataSource {
    var gripConfig: [Grip] = [.Continented, .Eastern, .SemiWestern, .Western]

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        gripConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: NSLocalizedString(gripConfig[indexPath.row].rawValue, comment: ""))
        return cell
    }
}

class backhandConfigViewDataSource: NSObject, UITableViewDataSource {
    var backhandConfig: [Backhand] = [.OneHanded, .TwoHandedBackhand]

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        backhandConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: NSLocalizedString(backhandConfig[indexPath.row].rawValue, comment: ""))
        return cell
    }
}
