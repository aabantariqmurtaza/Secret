//
//  User.swift
//  whatsApp
//
//  Created by Aaban Tariq on 27/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit

class User: NSObject {
    var emailId : String
    var password : String
    var nickName : String
    var language : String
    var userId : String? = nil
 
    init(email : String, u_Id:String, nick : String, lang: String, pass: String) {
        self.emailId = email
        self.userId = u_Id
        self.nickName = nick
        self.language = lang
        self.password = pass
        super.init()
    }
    
    func getJsonDictionary() -> Dictionary<String, String>{
        var dict : Dictionary<String, String> = Dictionary()
        
        dict[USER_LANGUAGE_KEY] = self.language
        dict[USER_ID_KEY] = self.userId
        dict[USER_EMAIL_ID_KEY] = self.emailId
        dict[USER_NICK_NAME_KEY] = self.nickName
        
        return dict
    }
}
