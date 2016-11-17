//
//  PasswordRecoveryViewController.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/16/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class PasswordRecoveryViewController: UIViewController,PasswordRecoveryPresenterView {
    
    private let passwordRecoveryPresenter = PasswordRecoveryPresenter(authService: AuthService())
    
    let passwordRecoveryView : PasswordRecoveryView = {
        let pv = PasswordRecoveryView()
        pv.pageLoading(isLoading: false)
        pv.showRecoveryInput()
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize presenter
        passwordRecoveryPresenter.attachView(view: self)
        
        // Do any additional setup after loading the view.
        view.addSubview(passwordRecoveryView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: passwordRecoveryView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: passwordRecoveryView)
        passwordRecoveryView.submitCodeBtn.addTarget(self, action: #selector(enterRecoveryCode), for: .touchUpInside)
        //forgotPasswordView.forgotPasswordBtn.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        
    }
    
    func enterRecoveryCode(){
        let recoveryCode = passwordRecoveryView.codeInput.text
        passwordRecoveryPresenter.recoveryCodeCheck(recoveryCode: recoveryCode)
    }
    
    func recoveryCodeValid(){
        passwordRecoveryView.showResetPasswordInput()
    }
    
    func submitNewPassword(){
        
    }
    
    func passwordRecovered(){
        performSegue(withIdentifier: "passwordRecovered", sender: nil)
    }
    
    func setRecoveryCodeResponseMsg(msg:String){
       passwordRecoveryView.errorMessage.text = msg
    }
    
    func setResetPasswordResponseMsg(msg:String){
       passwordRecoveryView.errorMessageResetPassword.text = msg
    }
    
    func startLoading(){
        passwordRecoveryView.pageLoading(isLoading: true)
    }
    
    func stopLoading(){
        passwordRecoveryView.pageLoading(isLoading: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
