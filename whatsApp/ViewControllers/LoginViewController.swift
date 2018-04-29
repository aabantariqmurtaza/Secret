//
//  LoginViewController.swift
//  whatsApp
//
//  Created by Aaban Tariq on 28/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let userInfo = returnModelFromUI()
        
        Auth.auth().signIn(withEmail: "aban.softengr@gmail.com", password: "123456") { (user, error) in
            if let _ = error {
                return
            }
            
            ApplicationData.activeUser = ApplicationData.returnFullUserForId(uid: (user?.uid)!)
            ApplicationData.syncChatUsers()
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let tabVC  = sb.instantiateViewController(withIdentifier: "tabBarVC")
            self.navigationController?.pushViewController(tabVC, animated: true)
        }
        
//        Auth.auth().signIn(withEmail: userInfo.emailId, password: userInfo.password) { (user, error) in
//            if let _ = error {
//                return
//            }
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let tabVC  = sb.instantiateViewController(withIdentifier: "tabBarVC")
//            self.navigationController?.pushViewController(tabVC, animated: true)
//        }
    }
    
    func returnModelFromUI() -> User {
        return User(email: emailTxtFld.text!, u_Id: "", nick: "", lang: "", pass: passwordTxtFld.text!)
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
