//
//  PopupViewController.swift
//  ReminderFirebase
//
//  Created by Luc Nguyen on 8/12/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import UIKit
import Firebase

class PopupViewController: UIViewController {

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .focused)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(handleSaveWork), for: .touchUpInside)
        button.layer.cornerRadius = 3
        return button
    }()
//    let loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("LOG IN", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        button.setTitleColor(UIColor.mainBlue(), for: .normal)
//        button.backgroundColor = .white
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
//        button.layer.cornerRadius = 5
//        return button
//    }()
    
    let cancelButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .focused)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        button.layer.cornerRadius = 3
        return button
    }()
    
    lazy var txField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Left Some Works here", isSecureTextEntry: false)
    }()
    
    lazy var datePicker : UIDatePicker = {
       let datePicker = UIDatePicker()
        
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    var ringTime : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAndConfigureComponents()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        showAnimation()
        
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        ringTime = Int(sender.date.timeIntervalSince1970)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func closePopup() {
        navigationController?.navigationBar.isHidden = false;
        self.view.viewWithTag(100)?.removeFromSuperview()
//        self.view.removeFromSuperview()
        removeAnimation()
    }
    
    func showAnimation() {
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1.0;
            
        }
    }
    
    func removeAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 0.0;
        }
    }

    @objc func handleSaveWork() {
//        let usrname = Auth.auth().
//        let user = Auth.auth().currentUser
        
//        print("101, ", user!.uid, user!.email)
        if let currentUser = Auth.auth().currentUser {
            var subWorks = [SubWorks]()
            var works = [Works]()
            var user = Users.self
            let work = Works()
            work.title = txField.text!
            works.append(work)
//            works[0].title = txField.text!
            user.init(email: currentUser.email!, works: works)
            print(user)
            
            
            print("Current user got")
        } else {
            print("Fail to get current user")
        }
        
//        print()
    }
    
    
    func loadAndConfigureComponents() {
        view.backgroundColor = UIColor.mainBlue();
        navigationController?.navigationBar.isHidden = true;
        
        view.addSubview(datePicker)
        datePicker.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 400, paddingRight: 20, width: 40, height: 80)
        
        
        view.addSubview(txField)
        txField.anchor(top: datePicker.bottomAnchor, left: datePicker.leftAnchor, bottom: view.bottomAnchor, right: datePicker.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 100, paddingRight: 0, width: 100, height: 80)
        
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        saveButton.anchor(top: txField.bottomAnchor, left: txField.leftAnchor, bottom: view.bottomAnchor, right: cancelButton.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 30, paddingRight: 80, width: 30, height: 20)
//        saveButton.topAnchor = txField.bottomAnchor
//        saveButton.bottomAnchor = view.bottomAnchor
        
        
        cancelButton.anchor(top: txField.bottomAnchor, left: saveButton.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 30, paddingRight: 10, width: 30, height: 20)
//        cancelButton.rightAnchor
        
//        txField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 100, height: 80)
        
        
        
    }
}

