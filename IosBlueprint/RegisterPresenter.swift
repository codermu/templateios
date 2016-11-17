//
//  RegisterPresenter.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/15/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation

protocol RegisterPresenterView : NSObjectProtocol{
    func register()
    func registerSuccess()
    func setResponseMsg(msg:String)
    func startLoading()
    func stopLoading()
}


class RegisterPresenter{
    private let userService : UserService
    weak private var fpView : RegisterPresenterView?
    
    init(userService : UserService){
        self.userService = userService
    }
    
    func attachView(view:RegisterPresenterView){
        self.fpView = view
    }
    
    func detachView(){
        self.fpView = nil
    }
    
    func registerSubmit(username:String, email:String , password:String , passwordConfirmation:String){
        
        self.fpView?.startLoading()
        
        if( password != passwordConfirmation){
            self.fpView?.setResponseMsg(msg: "Password confirmation doesn't match.")
            return
        }
        
        self.userService.register(username: username,email: email,password : password){
            resp in
            
            if (resp.message?.count)! > 0{
                let msg = resp.message?.joined(separator: ",")
                self.fpView?.setResponseMsg(msg: msg!)
            }else{
                self.fpView?.setResponseMsg(msg: resp.status)
            }
            
            self.fpView?.stopLoading()
            
        }
        
    }
    
    
}
