//
//  AuthService.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation
import KeychainAccess
import FBSDKLoginKit
import GoogleSignIn

var keychain = Keychain(service: "com.indosystem.arisan")

class AuthService {
    
    // sign in
    // send username/email and password to api
    // do sign in process on api
    // on success store oauth2 token in keychain
    // on fail return error
    func signIn(username:String,password:String , callback : @escaping (apiResponse) -> Void) {
        // do something
        
        let param : postParam = [
            "Email" : username,
            "Password" : password
        ]
        
        APIHandler.request(url: "http://staging.api.workforce.id/api/v1/user/login", requestMethod: .post, requestParam: param){
            resp in
            
            var messages = [String]()
            
            if let msg = resp["Message"] {
                messages = parseJsonToString(object: msg)
            }
            
            let response = apiResponse(status: resp["Status"] as! String, message: messages, data: resp["UserData"])
            
            callback(response)
        }

    }
    // send social sign in request to api
    func socialSignIn(socialName:String,token:String,email:String,name:String?,callBack : (apiResponse) -> Void){
        
        var messages = [String]()
        
        messages.append("Successfully logged in with "+socialName)
        
        let resp = apiResponse(status: "Ok", message: messages, data: nil)
        callBack(resp)
    }
    
    // logout
    // send signOut request to api
    // on success clean stored user data from apps
    func signOut(){
        do {
            
            // logout from social media
            
            facebookLogout()
            googleLogout()
            
            try keychain.remove("token")
        } catch let error {
            print("error: \(error)")
        }
    }
    
    // facebook logout
    func facebookLogout(){
        let fb = FBSDKLoginManager()
        fb.logOut()
    }
    // google logout
    func googleLogout(){
        GIDSignIn.sharedInstance().signOut()
    }
    
    // forgot password
    // request forgot password to api, send username/email to api
    // on fail return error
    func forgotPassword(userName:String,callBack : @escaping (apiResponse) -> Void ){
        
        // do something
        
        let param : postParam = [
            "email_target" : userName
        ]
        
        APIHandler.request(url: "http://staging.api.workforce.id/api/v1/user/forgotPassword", requestMethod: .post, requestParam: param){
            resp in
            
            
            var messages = [String]()
            
            if let msg = resp["Message"] {
                messages = parseJsonToString(object: msg)
            }
            
            let response = apiResponse(status: resp["Status"] as! String, message: messages, data: resp["UserData"])
            
            callBack(response)
        }
    }
    
    // check password recovery code
    // check whether the recovery code user entered for forgot password is valid
    
    func checkRecoveryCode(recoverycode:String,callback : (Bool) -> Void){
        // check recovery code
        
        callback(true)
    }
    
    // submit new password 
    func submitNewPassword(recoveryCode:String,password : String , callback : (apiResponse) -> Void ){
        //
    }
    
    // change password by forgot password
    
    func storeToken(token:String){
        debugPrint(keychain)
        do {
            try keychain.set(token, key: "token")
        }
        catch let error {
            print(error)
        }
    }
    
    class func getToken()->String?{
        return keychain["token"]
    }
    
}
