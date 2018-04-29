//
//  AllUsersViewController.swift
//  whatsApp
//
//  Created by Aaban Tariq on 28/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit

protocol AddToChatUsersProtocol {
    func addToChatUsers (user :User)
}

class AllUsersViewController: UIViewController {

    var chatUserVCRef : AddToChatUsersProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension AllUsersViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApplicationData.allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllUserCell = tableView.dequeueReusableCell(withIdentifier: "AllUserCell") as! AllUserCell
        cell.nameLbl.text = ApplicationData.allUsers[indexPath.row].nickName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chatUserVCRef?.addToChatUsers(user: ApplicationData.allUsers[indexPath.row])
        self.dismiss(animated: false, completion: nil)
    }
    
}
