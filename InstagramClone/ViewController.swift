//
//  ViewController.swift
//  InstagramClone
//
//  Created by Mehmet Bilir on 11.04.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            let auth = Auth.auth()
            auth.signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.alert(titleId: "Error!", MessageId: error?.localizedDescription ?? "Error!")
                }else {
                    self.performSegue(withIdentifier: "toMainVC", sender: nil)
                }
            }
        }
        
       
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if passwordText.text != "" && emailText.text != "" {
            
            let auth = Auth.auth()
            auth.createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.alert(titleId: "Error!", MessageId: error?.localizedDescription ?? "Error!")
                }else {
                    self.performSegue(withIdentifier: "toMainVC", sender: nil)
                }
            }
            
            
            
            
        }else {
            alert(titleId: "Error!", MessageId: "E-mail and Password must not be empty. ")
        }
        
        
        
    }
    
    func alert(titleId : String, MessageId : String){
        
        let alert = UIAlertController(title: titleId, message: MessageId, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

