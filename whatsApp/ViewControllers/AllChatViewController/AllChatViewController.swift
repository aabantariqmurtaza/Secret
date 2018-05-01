//
//  ChatViewController.swift
//  whatsApp
//
//  Created by Aaban Tariq on 24/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit
import Firebase

class AllChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    var to_user : User? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.datasourceUpdated), name: Notification.Name(ALL_CHAT_LIST_NOTIFICATION), object: nil)
    }

    @IBAction func popToLoginVC(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func presentAllUserVC(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let allUsersVC : AllUsersViewController  = sb.instantiateViewController(withIdentifier: "AllUsersVC") as! AllUsersViewController
        allUsersVC.chatUserVCRef = self
        self.present(allUsersVC, animated: true, completion: nil)
    }
    
    @objc func datasourceUpdated(){
        chatTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
  
}

extension AllChatViewController : AddToChatUsersProtocol{
    func addToChatUsers(user: User) {
        ApplicationData.addChatUser(user: user)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let singleChatVC : SingleChatViewController  = sb.instantiateViewController(withIdentifier: "SingleChatViewController") as! SingleChatViewController
        singleChatVC.messages = ApplicationData.chatList.last?.chatlist
        self.navigationController?.pushViewController(singleChatVC, animated: false)
    }
}

extension AllChatViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ApplicationData.chatList.count);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let singleChatVC : SingleChatViewController  = sb.instantiateViewController(withIdentifier: "SingleChatViewController") as! SingleChatViewController
//        ApplicationData.returnMessageArrayAgainst(sender: ApplicationData.activeUser!, reciever: ApplicationData.chatList[indexPath.row].user)
        _ = ApplicationData.chatList[indexPath.row].chatlist
        singleChatVC.messages = ApplicationData.chatList[indexPath.row].chatlist
        singleChatVC.to_user = ApplicationData.chatList[indexPath.row].user
        self.navigationController?.pushViewController(singleChatVC, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllChatCellView = tableView.dequeueReusableCell(withIdentifier: "AllChatViewCell") as! AllChatCellView
        let item : ChatUserModel  = ApplicationData.chatList[indexPath.row]
        cell.usernameLbl.text = item.user.nickName
        
        return cell
    }
}
