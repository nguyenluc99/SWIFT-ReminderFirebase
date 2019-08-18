//
//  PopupViewController.swift
//  ReminderFirebase
//
//  Created by Luc Nguyen on 8/12/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .focused)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleSaveWork), for: .touchUpInside)
        button.layer.cornerRadius = 3
        return button
    }()
    
    lazy var txField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Left Some Works here", isSecureTextEntry: false)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAndConfigureComponents()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        showAnimation()
        
        let datePicker: UIDatePicker = UIDatePicker()
        
//        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
//        datePicker.frame = CGRect(origin: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2), size: CGSize(width: self.view.frame.width*3/4, height: self.view.frame.width/2))
        datePicker.frame = CGRect(x: self.view.frame.width/8, y: self.view.frame.height/2 - self.view.frame.width/4, width: self.view.frame.width*3/4, height: self.view.frame.width/2)
        
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        
        datePicker.addTarget(self, action: #selector(PopupViewController.datePickerValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(datePicker)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        print("Selected value \(selectedDate)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func closePopup() {
        self.view.removeFromSuperview()
        removeAnimation()
    }
    
    func showAnimation() {
//        self.view.transform = CGAffineTransfo
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
        
    }
    
    
    func loadAndConfigureComponents() {
        view.backgroundColor = UIColor.mainBlue();
        navigationController?.navigationBar.isHidden = true;
        
        view.addSubview(txField)
        
        
    }
}

