//
//  ViewController.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/10/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController,LoginPresenterView,GIDSignInUIDelegate {
    
    private let loginPresenter = LoginPresenter(authService: AuthService())
    
    let loginView : LoginView = {
       let lv = LoginView()
           lv.pageLoading(isLoading: false)
       return lv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // attach view to presenter
        loginPresenter.attachView(view: self)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(loginView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: loginView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: loginView)
        
        loginView.signInBtn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        loginView.registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        loginView.forgotPasswordBtn.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        loginView.facebookSignInBtn.addTarget(self, action: #selector(handleFacebookSignIn), for: .touchUpInside)
        loginView.googleSignInBtn.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        // seting up facebook login
        //setupFacebookLogin()

    }
    
    func handleGoogleSignIn(){
       GIDSignIn.sharedInstance().signIn()
    }
    
    // get current logged in user
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        let user = signIn.currentUser!
        self.loginPresenter.googleSignIn(id: user.authentication.idToken, email: user.profile.email, name: user.profile.name)
    }
    
    func handleFacebookSignIn(){
        self.loginPresenter.facebookSignIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginView.errorMessage.text = ""
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signIn() {
        let username = loginView.userNameInput.text
        let password = loginView.passwordInput.text
        
        loginPresenter.signInSubmit(username: username, password: password)
    }
    
    func signInSuccess() {
        performSegue(withIdentifier: "dashboard", sender: nil)
    }
    
    func setLoginError(errorMessage: String) {
        loginView.errorMessage.text = errorMessage
    }
    
    func startLoading() {
        loginView.pageLoading(isLoading: true)
    }
    
    func stopLoading() {
        loginView.pageLoading(isLoading: false)
    }
    
    func register(){
        performSegue(withIdentifier: "register", sender: nil)
    }
    
    func forgotPassword(){
        performSegue(withIdentifier: "forgotPassword", sender: nil)
    }
}
