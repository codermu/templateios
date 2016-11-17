//
//  ForgotPasswordView.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/11/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView  , NIBViewProtocol{
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    
    
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
