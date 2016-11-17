//
//  ForgotPasswordViewController.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,ForgotPasswordPresenterView {
    
    private let forgotPasswordPresenter = ForgotPasswordPresenter(authService: AuthService())

    let forgotPasswordView : ForgotPasswordView = {
       let fpv = ForgotPasswordView()
        fpv.pageLoading(isLoading: false)
        return fpv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize presenter
        forgotPasswordPresenter.attachView(view: self)
        
        // Do any additional setup after loading the view.
        view.addSubview(forgotPasswordView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: forgotPasswordView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: forgotPasswordView)
        forgotPasswordView.forgotPasswordBtn.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func forgotPassword() {
        forgotPasswordPresenter.forgotPasswordSubmit(username: forgotPasswordView.userNameInput.text)
    }
    
    func forgotPasswordConfirm() {
        // continue to forgot password confirmation scene
        performSegue(withIdentifier: "confirmForgotPassword", sender: nil)
    }
    
    func setResponseMsg(msg: String) {
        forgotPasswordView.errorMessage.text = msg
    }
    
    func startLoading() {
        forgotPasswordView.pageLoading(isLoading: true)
    }
    
    func stopLoading() {
        forgotPasswordView.pageLoading(isLoading: false)
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
