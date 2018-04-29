//
//  ChatUserModel.swift
//  whatsApp
//
//  Created by Aaban Tariq on 28/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit

class ChatUserModel: NSObject {
    var user : User
    var chatlist : Array<OneMessageModel>
    init(usr : User, list : Array<OneMessageModel>) {
        user = usr
        chatlist = list
        super.init()
    }
    
    func getJsonDictionary() -> Dictionary<String, Any> {
        var dict : Dictionary<String, Any> = Dictionary()
        dict[TO_USER_NICKNAME_KEY] = user.nickName
        var array : Array<Dictionary<String, String>> = Array()
        for item in chatlist {
            array.append(item.getJsonDictionary())
        }
        dict[MESSAGES_ARRAY_KEY] = array
        return dict
    }
    
    func getJsonDictionary(nickNameException :String) -> Dictionary<String, Any> {
        var dict : Dictionary<String, Any> = Dictionary()
        dict[TO_USER_NICKNAME_KEY] = nickNameException
        var array : Array<Dictionary<String, String>> = Array()
        for item in chatlist {
            array.append(item.getJsonDictionary())
        }
        dict[MESSAGES_ARRAY_KEY] = array
        return dict
    }
}
