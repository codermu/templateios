//
//  GoogleSignInHandler.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/18/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleSignInHandler : NSObject, GIDSignInDelegate{
    
    override init() {
        super.init()
        // initialize google sign in
        // change with your clientID
        GIDSignIn.sharedInstance().clientID = "147669906409-c9bd2km71jddas9b5rqjkf5n16fabu36.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
    }
    
    // google sign in event
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // code on sign in
        if (error == nil) {
            
            // Perform any operations on signed in user here.
            //            let userId = user.userID                  // For client-side use only!
            //            let idToken = user.authentication.idToken // Safe to send to the server
            //            let fullName = user.profile.name
            //            let givenName = user.profile.givenName
            //            let familyName = user.profile.familyName
            //            let email = user.profile.email
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // code on disconect
    }
    
    func handleUrl(open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]){
        GIDSignIn.sharedInstance().handle(url,
                                          sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,
                                          annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    
}
