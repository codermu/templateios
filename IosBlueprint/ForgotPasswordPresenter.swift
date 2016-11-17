//
//  ForgotPasswordPresenter.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/15/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation

protocol ForgotPasswordPresenterView : NSObjectProtocol{
    func forgotPassword()
    func forgotPasswordConfirm()
    func setResponseMsg(msg:String)
    func startLoading()
    func stopLoading()
}


class ForgotPasswordPresenter{
    private let authService : AuthService
    weak private var fpView : ForgotPasswordPresenterView?
    
    init(authService : AuthService){
        self.authService = authService
    }
    
    func attachView(view:ForgotPasswordPresenterView){
        self.fpView = view
    }
    
    func detachView(){
        self.fpView = nil
    }
    
    func forgotPasswordSubmit(username:String?){
        
        self.fpView?.startLoading()
        
        self.authService.forgotPassword(userName: username!){
            resp in
            
            if resp.status == "Ok" {
                // continue to next step
                self.fpView?.forgotPasswordConfirm()
            }else{
                // show error message
                self.fpView?.setResponseMsg(msg: resp.status)
            }
            
            self.fpView?.stopLoading()
            
        }
        
    }
    
    
}
