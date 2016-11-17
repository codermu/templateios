//
//  RegisterViewController.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let registerView : RegisterView = {
       let rv = RegisterView()
        rv.pageLoading(isLoading: false)
        return rv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(registerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: registerView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: registerView)
        registerView.registerBtn.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
        
    }
    
    // register process
    func registerAccount(){
     // do something
        print("register")
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
