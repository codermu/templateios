//
//  DashboardViewController.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/14/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var token: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let oauth2Token = AuthService.getToken()
        
        token.text = oauth2Token
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutBtn_tap(_ sender: AnyObject) {
        
        
       // sample of logout process
       let auth =  AuthService()
        auth.signOut()
        
        self.navigationController?.popToRootViewController(animated: true)
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
