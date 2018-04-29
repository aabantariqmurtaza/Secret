//
//  SignupViewController.swift
//  whatsApp
//
//  Created by Aaban Tariq on 24/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit
import Firebase


class SignupViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var nickNameTxtFld: UITextField!
    @IBOutlet weak var language: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        let userInfo = returnModelPreparedFromUI()
        Auth.auth().createUser(withEmail: userInfo.emailId, password: userInfo.password) { (user, error) in
            if let _ = error{
                print(error?.localizedDescription)
                return
            }
            userInfo.userId = user?.uid
            ApplicationData.syncUser(user: userInfo)
            self.displayAlert()
        }
    }
    
    func returnModelPreparedFromUI() -> User {
        return User(email: emailTxtFld.text!, u_Id: "", nick: nickNameTxtFld.text!, lang: language.text!, pass: passwordTxt.text!)
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "Message",
                                      message: "User Created Succesfully, Please Login",
                                      preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "OK",
                                          style: .default) {(_) in
                                            
                                            
                                            
                                            
                                            
                                            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(defaultButton)
        present(alert, animated: true) {
            // completion goes here
        }
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
