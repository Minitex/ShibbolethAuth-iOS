//
//  ViewController.swift
//  ShibbolethAuth
//
//  Created by Vui Nguyen on 3/15/19.
//  Copyright © 2019 Minitex. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var loginStatusLabel: UILabel!
  @IBOutlet weak var loginSignOutButton: UIButton!

  @IBAction func login(_ sender: Any) {
    toggleLogin()
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
}

