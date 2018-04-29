//
//  ApplicationData.swift
//  whatsApp
//
//  Created by Aaban Tariq on 28/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ApplicationData: NSObject {
    
    static var allUsers : Array<User> = Array()
    static var activeUser : User? = nil
    static var chatList : Array<ChatUserModel> = Array()
    static var particularChatList : Array<OneMessageModel> = Array()
    static var loggedInUser : User? = nil
    
    static func returnMessageArrayAgainst(sender :User, reciever : User){
        var chat_array : Array<OneMessageModel> = Array()
        var childRef : DatabaseReference? = nil
        if let s_uid = sender.userId{
            if let r_uid = reciever.userId{
                childRef = Database.database().reference(withPath: "ChatList/\(s_uid)/\(r_uid)/messages")
            }
        }
        
        childRef?.observe(.value) { (snapshot) in
            if let valueExist = snapshot.value{
                if let validMessages = valueExist as? Array<Dictionary<String, String>>{
                    chat_array = Array()
                    for singleMessageDict in validMessages {
                        let message = singleMessageDict[MESSAGE_KEY]
                        let to_user_id = singleMessageDict[TO_USER_KEY]
                        let from_user_id = singleMessageDict[FROM_USER_KEY]
                        chat_array.append(OneMessageModel(msg_: message!, to_user: User(email: "", u_Id: to_user_id!, nick: "", lang: "", pass: ""), from_user: User(email: "", u_Id: from_user_id!, nick: "", lang: "", pass: "")))
                    }
                    particularChatList = chat_array
                    var respectiveChatUserModel : ChatUserModel? = nil
                    for item in self.chatList {
                        if (item.user.userId == reciever.userId!){
                            respectiveChatUserModel = item
                            respectiveChatUserModel?.chatlist = particularChatList
                        }
                    }
                    NotificationCenter.default.post(name: Notification.Name(PARTICULAR_CHAT_LIST_NOTIFICATION), object: nil)
                }
            }
        }
    }
    
    static func getChatAgainstUser(user :User){
        
    }
    
    static func syncUser(user : User){
        var userDictArray : Array<Dictionary<String, String>> = Array()
        
        var index = 0
        for _user in self.allUsers {
            if (_user.userId == user.userId){
                break;
            }
            index = index + 1
        }
        let userRef : DatabaseReference = Database.database().reference(withPath: "Users")
        if (index == self.allUsers.count){
            self.allUsers.append(user)
        }
        for user_ in self.allUsers {
            userDictArray.append(user_.getJsonDictionary())
        }
        userRef.setValue(userDictArray)
    }
    
    static func syncAllUsers(){
        var users : Array<User> = Array()
        
        let childRef : DatabaseReference = Database.database().reference(withPath: "Users")
        childRef.observe(.value) { (snapshot) in
            if let valueExist = snapshot.value{
                if let validUsers = valueExist as? Array<Dictionary<String, String>>{
                    users = Array()
                    for singleUserDict in validUsers {
                        let nickName = singleUserDict[USER_NICK_NAME_KEY]
                        let emailId = singleUserDict[USER_EMAIL_ID_KEY]
                        let userId = singleUserDict[USER_ID_KEY]
                        let langugage = singleUserDict[USER_LANGUAGE_KEY]
                        users.append(User(email: emailId!, u_Id: userId!, nick: nickName!, lang: langugage!, pass: ""))
                    }
                    self.allUsers = users
                    NotificationCenter.default.post(name: Notification.Name(PARTICULAR_CHAT_LIST_NOTIFICATION), object: nil)
                }
            }
        }
    }
    
    static func syncChatUsers(){
        var chatUsers : Array<ChatUserModel> = Array()
        var userRef : DatabaseReference? = nil
        if let uid = self.activeUser?.userId {
            userRef = Database.database().reference(withPath: "ChatList/\(uid)")
        }
        
        userRef?.observe(.value) { (snapshot) in
            if let valueExist = snapshot.value{
                if let validChatUsers = valueExist as? Dictionary<String, Dictionary<String, Any>>{
                    chatUsers = Array()
                    
                    for (key, value) in validChatUsers {
                        let nickName = value[TO_USER_NICKNAME_KEY]
                        let userid = key
                        let msgsArrayDict : Array<Dictionary<String, String>> = value[MESSAGES_ARRAY_KEY] as! Array<Dictionary<String, String>>
                        var msgsArrayModels : Array<OneMessageModel> = Array()
                        for oneMsg in msgsArrayDict {
                            msgsArrayModels.append(OneMessageModel(msg_: oneMsg[MESSAGE_KEY]!, to_user: User(email: "", u_Id: oneMsg[TO_USER_KEY]!, nick: "", lang: "", pass: ""), from_user: User(email: "", u_Id: oneMsg[FROM_USER_KEY]!, nick: "", lang: "", pass: "")))
                        }
                        chatUsers.append(ChatUserModel(usr: User(email: "", u_Id: userid , nick: nickName as! String, lang: "", pass: ""), list: msgsArrayModels))
                    }
                    
                    self.chatList = chatUsers
                    NotificationCenter.default.post(name: Notification.Name(ALL_CHAT_LIST_NOTIFICATION), object: nil)
                }
            }
        }
    }
    
    static func addOneMessage(message :OneMessageModel){
        var respectiveChatUserModel : ChatUserModel? = nil
        for item in self.chatList {
            if (item.user.userId == message.to?.userId){
                respectiveChatUserModel = item
            }
        }
        
        var senderRef : DatabaseReference? = nil
        var recieverRef : DatabaseReference? = nil
        if let validModel = respectiveChatUserModel{
            validModel.chatlist.append(message)
            if let uid = self.activeUser?.userId {
                if let u_id = message.to?.userId {
                    senderRef = Database.database().reference(withPath: "ChatList/\(uid)/\(u_id)/messages")
                    recieverRef = Database.database().reference(withPath: "ChatList/\(u_id)/\(uid)/messages")
                }
            }
            
            var array : Array<Dictionary<String, String>> = Array()
            for msg in validModel.chatlist {
                array.append(msg.getJsonDictionary())
            }
            senderRef?.setValue(array)
            recieverRef?.setValue(array)
        }
    }
    
    static func returnFullUserForId (uid : String) -> User? {
        for item in self.allUsers {
            if (item.userId == uid){
                return item
                break
            }
        }
        
        return nil
    }
    
    static func addChatUser(user :User){
        self.chatList.append(ChatUserModel(usr: user, list: Array(arrayLiteral: OneMessageModel(msg_: "Hi", to_user: user, from_user: ApplicationData.activeUser!))))
        
        var senderRef : DatabaseReference? = nil
        var receiverRef : DatabaseReference? = nil
        
        for item in self.chatList {
            if (item.user.userId == user.userId){
                if let uid = self.activeUser?.userId {
                    senderRef = Database.database().reference(withPath: "ChatList/\(uid)/\(item.user.userId!)")
                    receiverRef = Database.database().reference(withPath: "ChatList/\(item.user.userId!)/\(uid)")
                }
                senderRef?.setValue(item.getJsonDictionary())
                receiverRef?.setValue(item.getJsonDictionary(nickNameException: (self.activeUser?.nickName)!))
            }
        }
    }

}
