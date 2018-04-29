//
//  SingleChatViewController.swift
//  whatsApp
//
//  Created by Aaban Tariq on 24/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.


import UIKit

class SingleChatViewController: UIViewController {

    @IBOutlet weak var chatTxtField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    var to_user : User? = nil
    var messages : Array<OneMessageModel>? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.datasourceUpdated), name: Notification.Name(PARTICULAR_CHAT_LIST_NOTIFICATION), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func datasourceUpdated(){
        var respectiveChatUserModel : ChatUserModel? = nil
        for item in ApplicationData.chatList {
            if (item.user.userId == to_user?.userId){
                respectiveChatUserModel = item
                self.messages = respectiveChatUserModel?.chatlist
            }
        }
        chatTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if (messages?.first?.to?.userId == ApplicationData.activeUser?.userId){
            ApplicationData.addOneMessage(message: OneMessageModel(msg_: chatTxtField.text!, to_user: (messages?.first?.from)!, from_user: ApplicationData.activeUser!))
        }else{
            ApplicationData.addOneMessage(message: OneMessageModel(msg_: chatTxtField.text!, to_user: (messages?.first?.to)!, from_user: ApplicationData.activeUser!))
        }
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension SingleChatViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (messages?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message : OneMessageModel = messages![indexPath.row]
        
        if (ApplicationData.activeUser?.userId == message.from?.userId){
            let cell : SingleChatMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "singleChatSenderCell") as! SingleChatMessageTableViewCell
            cell.messageLbl.text = message.msg
            return cell
        }else{
            let cell : SingleChatReceiverCell = tableView.dequeueReusableCell(withIdentifier: "SingleChatReceiverCell") as! SingleChatReceiverCell
            cell.msgLbl.text = message.msg
            return cell
        }
//        self.updateTableContentInset(tableView_: tableView)
    }
    
    func updateTableContentInset(tableView_ :UITableView) {
        
        let numRows = tableView(tableView_, numberOfRowsInSection: 0)
        var contentInsetTop = tableView_.bounds.size.height
        for i in 0..<numRows {
            let rowRect = tableView_.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        tableView_.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0)
    }
}
