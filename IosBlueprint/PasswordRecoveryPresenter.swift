//
//  File.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/16/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation

protocol PasswordRecoveryPresenterView : NSObjectProtocol{
    func enterRecoveryCode()
    func recoveryCodeValid()
    func submitNewPassword()
    func setRecoveryCodeResponseMsg(msg:String)
    func setResetPasswordResponseMsg(msg:String)
    func startLoading()
    func stopLoading()
}


class PasswordRecoveryPresenter{
    private let authService : AuthService
    weak private var fpView : PasswordRecoveryPresenterView?
    
    init(authService : AuthService){
        self.authService = authService
    }
    
    func attachView(view:PasswordRecoveryPresenterView){
        self.fpView = view
    }
    
    func detachView(){
        self.fpView = nil
    }
    
    func recoveryCodeCheck(recoveryCode:String?){
        
        self.fpView?.startLoading()
        
        self.authService.checkRecoveryCode(recoverycode:recoveryCode!){
            resp in
            
            if (resp == true){
                self.fpView?.recoveryCodeValid()
            }else{
                self.fpView?.setRecoveryCodeResponseMsg(msg: "Recovery code not valid")
            }
            
            self.fpView?.stopLoading()

        }
        
    }
    
    func submitNewPassword(password:String?, rePassword:String?){
        
        if password == "" || rePassword == "" {
            fpView?.setResetPasswordResponseMsg(msg: "Password or Password Confirmation cannot be null")
            return
        }
        
        self.fpView?.startLoading()
        
        
    }
    
    
}
