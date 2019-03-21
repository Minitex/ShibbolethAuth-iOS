//
//  ViewController.swift
//  ShibbolethAuth
//
//  Created by Vui Nguyen on 3/15/19.
//  Copyright © 2019 Minitex. All rights reserved.
//

import UIKit
import AuthenticationServices

class MainViewController: UIViewController {

  @IBOutlet weak var loginStatusLabel: UILabel!
  @IBOutlet weak var loginSignOutButton: UIButton!

  var webAuthSession: ASWebAuthenticationSession?

  @IBAction func login(_ sender: Any) {
    //toggleLogin()
    openLoginPage()
  }

  var loginStatus: Bool = false
  let signedOutLabelText = "Not Logged In"
  let signedOutButtonText = "Login"

  let loggedInLabelText = "Signed In as Columbia User"
  let loggedInButtonText = "Sign Out"

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    displayLoginStatus()
  }


  // Helper function
  func displayLoginStatus() {
    loginStatusLabel.text = (loginStatus == false) ? signedOutLabelText : loggedInLabelText
    if loginStatus == true {
      loginStatusLabel.text = loggedInLabelText
      loginSignOutButton.setTitle(loggedInButtonText, for: .normal)
    } else {
      loginStatusLabel.text = signedOutLabelText
      loginSignOutButton.setTitle(signedOutButtonText, for: .normal)
    }

  }

  func toggleLogin() {
    loginStatus = !loginStatus
    displayLoginStatus()
  }

  @available(iOS 12.0, *)
  func openLoginPage() {
    print("opening login page!")

    let authURL = URL(string: "https://shib.minitex.net/secure/test.txt")
    let callbackUrlScheme = "https://shib.minitex.net/"
    //let callbackUrlScheme = "shibboleth-web-flow-example://auth"

    self.webAuthSession = ASWebAuthenticationSession.init(url: authURL!, callbackURLScheme: callbackUrlScheme, completionHandler: { (callBack:URL?, error:Error?) in

      // handle auth response
     // guard error == nil, let successURL = callBack else {

     //   return
     // }

      guard error == nil else {
        print("we have an error! Error: \(String(describing: error?.localizedDescription))")
        return
      }

      guard let successURL = callBack else {
        print("no success in successURL! callBackURL is \(String(describing: callBack))")
        return
      }

      print("we made it this far!")

      let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first

      // Do what you now that you've got the token, or use the callBack URL
      print(oauthToken ?? "No OAuth Token")
    })

    // Kick it off
    self.webAuthSession?.start()

  }
}

