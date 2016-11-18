//
//  LoginPresenter.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation
import GoogleSignIn
import FBSDKLoginKit

// socialMedia view protocol
@objc protocol LoginPresenterView:NSObjectProtocol {
    func signIn()
    func signInSuccess()
    func setLoginError(errorMessage:String)
    
    // socia media login
    @objc optional func handleFacebookSignIn()
    @objc optional func handleGoogleSignIn()
    
    func startLoading()
    func stopLoading()
}

class LoginPresenter : GoogleSignInHandler{
    private let authService : AuthService
    weak private var loginView : LoginPresenterView?
    
    init(authService : AuthService){
        self.authService = authService
    }
    
    func attachView(view:LoginPresenterView){
        self.loginView = view
    }
    
    func detachView(){
        self.loginView = nil
    }
    
    func signInSubmit(username:String?,password:String?){
        
        // validate if username or password is nil
        
        if username == "" || password == ""{
            self.loginView?.setLoginError(errorMessage: "Username or password is empty")
            return
        }
        
        self.loginView?.startLoading()
        
        self.authService.signIn(username: username!, password: password!){
            resp in
            
            if let result = resp.data{
                // signin success
                if let oauth2Token = result["Token"]{
                    // if signin success and api send oauth2 token
                    
                    // store token to keychain
                    self.authService.storeToken(token: oauth2Token as! String)
                    
                    self.loginView?.signInSuccess()
                }else{
                    self.loginView?.setLoginError(errorMessage: "Login invalid")
                    return
                }
            }else{
                // let message = resp.message?.joined(separator: ", ")
                // self.loginView?.setLoginError(errorMessage: message!)
                
                self.loginView?.setLoginError(errorMessage: resp.status)
            }
            
            self.loginView?.stopLoading()
            
        }
        
    }
    
    func facebookSignIn(){
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self.loginView as! UIViewController!) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err)
                return
            }
            
            self.showEmailAddress()
        }
    }
    
    override func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    
        // code on sign in
        if (error == nil) {
            self.googleSignIn(id: user.authentication.idToken, email: user.profile.email, name: user.profile.name)
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func googleSignIn(id:String,email:String,name:String){
        self.authService.socialSignIn(socialName: "google", token: id, email: email, name: name){
            resp in
            
            if resp.status == "Ok"{
                self.loginView?.signInSuccess()
            }else{
                let msg = resp.message?.joined(separator: ", ")
                self.loginView?.setLoginError(errorMessage: msg!)
            }
            
        }
        // continue login process
    }
    
    func showEmailAddress() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print("Failed to start graph request:", err)
                return
            }

            let userData = result as? [String:AnyObject]
            let email     = userData?["email"] as? String
            let userID = userData?["id"] as? String
            let name  = userData?["name"] as? String
            
            self.authService.socialSignIn(socialName: "facebook", token: userID!, email: email!, name:name){
                resp in
                
                if resp.status == "Ok"{
                    self.loginView?.signInSuccess()
                }else{
                    let msg = resp.message?.joined(separator: ", ")
                    self.loginView?.setLoginError(errorMessage: msg!)
                }
            }
            // result["email"], result["id"], result["name"]
        }
    }
    
    
}

