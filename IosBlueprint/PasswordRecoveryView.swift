//
//  ForgotPasswordConfirmationView.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/15/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class PasswordRecoveryView: UIView  , NIBViewProtocol{
    
    @IBOutlet weak var recoveryView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeInput: UITextField!
    @IBOutlet weak var submitCodeBtn: UIButton!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var rePasswordLabel: UILabel!
    @IBOutlet weak var rePasswordInput: UITextField!
    @IBOutlet weak var errorMessageResetPassword: UILabel!
    @IBOutlet weak var resetPasswordSubmit: UIButton!
    
    
    
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        
        // additional option
        loading.hidesWhenStopped = true
    }
    
    func pageLoading(isLoading:Bool){
        emptyView.isHidden = !isLoading
        
        if isLoading {
            loading.startAnimating()
        }else{
            loading.stopAnimating()
        }
        
    }
    
    func showRecoveryInput(){
        resetPasswordView.isHidden = true
        recoveryView.isHidden      = false
    }
    
    func showResetPasswordInput(){
        recoveryView.isHidden      = true
        resetPasswordView.isHidden = false
    }
    
    func xibSetup() {
        
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
