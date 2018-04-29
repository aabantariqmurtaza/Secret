//
//  OneMessageModel.swift
//  whatsApp
//
//  Created by Aaban Tariq on 28/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit

class OneMessageModel: NSObject {
    var msg : String = ""
    var to : User? = nil
    var from : User? = nil
    
    init(msg_ : String, to_user : User, from_user :User) {
        msg = msg_
        
        to = to_user
        from = from_user
        super.init()
    }
    
    func getJsonDictionary() -> Dictionary<String, String> {
        var dict : Dictionary<String, String> = Dictionary()
        dict[MESSAGE_KEY] = msg
        dict[TO_USER_KEY] = to?.userId
        dict[FROM_USER_KEY] = from?.userId
        return dict
    }
}
