//
//  SettingsViewController.swift
//  submarine
//
//
//

import UIKit
import FirebaseAuth
import FirebaseCore

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButton(_ sender: Any) {let auth = Auth.auth()
        do {
            try auth.signOut()
            print("로그아웃 성공")
            
            let main = UIStoryboard.init(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(identifier: "loginViewController")
            loginViewController.modalTransitionStyle = .coverVertical
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
            
        } catch let logoutError as NSError {
            print("로그아웃 에러: ", logoutError)
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print(error)
            }
            else {
                print("delete account")
                let main = UIStoryboard.init(name: "Main", bundle: nil)
                let loginViewController = main.instantiateViewController(identifier: "loginViewController")
                loginViewController.modalTransitionStyle = .coverVertical
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func settingsBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
