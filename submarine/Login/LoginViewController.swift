//
//  LoginViewController.swift
//  submarine
//
//
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var signupPasswordCheck: UITextField!
    @IBOutlet weak var signupEmailError: UILabel!
    @IBOutlet weak var signupPasswordError: UILabel!
    @IBOutlet weak var signupPasswordCheckError: UILabel!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var resetEmail: UITextField!
    @IBOutlet weak var resetError: UILabel!
    
    var termsCheck = false
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("\(user.email ?? "nil")")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = handle {
            Auth.auth().removeStateDidChangeListener(handle!)
        }
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
        guard let email = self.signupEmail.text else { return }
        guard let password = self.signupPassword.text else { return }
        guard let passwordCheck = self.signupPasswordCheck.text else { return }
        
        self.signupEmailError.text = ""
        self.signupPasswordError.text = ""
        self.signupPasswordCheckError.text = ""
        
        if self.termsCheck == true {
            if password != passwordCheck {
                self.signupPasswordCheckError.text = "비밀번호가 일치하지 않습니다."
            }
            else {
                if password == passwordCheck {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if let error = error { print(error)
                            
                            let errorcode = error as NSError
                            
                            switch errorcode.code{
                                
                            case AuthErrorCode.invalidEmail.rawValue:
                                self.signupEmailError.text = "이메일 형식이 잘못되었습니다."
                            case AuthErrorCode.emailAlreadyInUse.rawValue:
                                self.signupEmailError.text = "이미 존재하는 이메일입니다."
                            case AuthErrorCode.weakPassword.rawValue:
                                self.signupPasswordError.text = "6자 이상의 비밀번호가 아닙니다."
                            default:
                                print("error")
                            }
                        }
                        
                        if let result = authResult, let userEmail = result.user.email {
                            print("\(userEmail) 가입 완료")
                            let loginViewController = self.storyboard?.instantiateViewController(identifier: "loginViewController")
                            loginViewController?.modalTransitionStyle = .coverVertical
                            loginViewController?.modalPresentationStyle = .fullScreen
                            self.present(loginViewController!, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func termsCheckButton(_ sender: Any) {
        
        if termsCheck == false {
            termsCheck = true
            termsButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: UIControl.State.normal)
        }
        else {
            termsCheck = false
            termsButton.setImage(UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        guard let email = self.loginEmail.text else { return }
        guard let password = self.loginPassword.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error { print(error) }
            if let result = authResult, let userEmail =  result.user.email {
                print("\(userEmail)으로 로그인")
                let mainViewController = self?.storyboard?.instantiateViewController(identifier: "Main")
                mainViewController?.modalTransitionStyle = .coverVertical
                mainViewController?.modalPresentationStyle = .fullScreen
                self?.present(mainViewController!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        guard let email = self.resetEmail.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard let error = error else
            {
                print("재설정 메일 발송")
                return
            }
            let nsError : NSError = error as NSError
            switch nsError.code
            {
            case 17011:
                print("존재하지 않는 이메일입니다.")
                self.resetError.text = "존재하지 않는 이메일입니다."
            default:
                break
            }
        }
    }
    
    @IBAction func resetBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
    }
    
    @IBAction func signupBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
