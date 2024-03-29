//
//  HomeViewController.swift
//  ReminderFirebase
//
//  Created by Luc Nguyen on 8/12/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    // MARK _ Create Components
    
//    let datePicker: UIDatePicker = UIDatePicker()
//    datePicker.frame = CGRect(x)
    
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()
    
    var tableWorks : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    } ()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.loadView()
        print("Helloooo")
        
        authenticateUserAndConfigureView()
//        configureViewComponents()
        setupTableView()
    }
    
    // MARK: - Selectors
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleAddNewWork() {
//        let navController = UINavigationController(rootViewController: PopupViewController())
//        navController.navigationBar.barStyle = .black
//        let popVC = UIStoryboard(
//        let popupVC = UIStoryboard(name:, bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        let popupVC = PopupViewController()
        self.addChild(popupVC)
//        popupVC.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 80))
        popupVC.view.frame = self.view.frame
        popupVC.view.tag = 100
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
//        self.present(navController, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Nonde uid")
            return }
        Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
            guard let username = snapshot.value as? String else {
                print("Failed")
                return
                
            }
            self.welcomeLabel.text = "Welcome, \(username)"
            
            UIView.animate(withDuration: 0.5, animations: {
                self.welcomeLabel.alpha = 1
            })
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            let navController = UINavigationController(rootViewController: LoginViewController())
            navController.navigationBar.barStyle = .black
            self.present(navController, animated: true, completion: nil)
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }
    
    func authenticateUserAndConfigureView() {
        print("current user is : ", Auth.auth().currentUser)
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginViewController())
                navController.navigationBar.barStyle = .black
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            print("Load")
            configureViewComponents()
            print("Configured")
            loadUserData()
            print("Done")
        }
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBlue()
        
        navigationItem.title = "Firebase Login"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "firebase-logo"), style: .plain, target: self, action: #selector(handleAddNewWork))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.mainBlue()
        
        view.addSubview(tableWorks)
//        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func setupTableView() {
        tableWorks.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
//        tableWorks.delegate = self
//        tableWorks.dataSource = self
        view.addSubview(tableWorks)
        
        NSLayoutConstraint.activate([
            tableWorks.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableWorks.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableWorks.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableWorks.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
    }
}
// MARK : FUNCTION


extension HomeTableViewCell : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for : indexPath) as! HomeTableViewCell
        return cell
    }
    
}
