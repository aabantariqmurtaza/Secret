//
//  Constants.swift
//  whatsApp
//
//  Created by Aaban Tariq on 28/04/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit

let ACCESS_TOKEN = "ya29.GlutBZrzW0Spf0wLG20EV6TB21D4J7WsC1muoaAicMTOKV2JBIbtzO095jBGkR81XmeQYGJAgAWwcOY8VEhqsVmlij-yW18y0ovXRjlDFwvg7VwJ0N0_2EI3D12B"


let USER_NICK_NAME_KEY = "username"
let USER_EMAIL_ID_KEY = "userEmail"
let USER_ID_KEY = "userId"
let USER_LANGUAGE_KEY = "userLanguage"

let MESSAGES_ARRAY_KEY = "messages"
let MESSAGE_KEY = "message"
let TO_USER_KEY = "to_user"
let TO_USER_NICKNAME_KEY = "to_user_nickname"
let FROM_USER_KEY = "from_user"
let PARTICULAR_CHAT_LIST_NOTIFICATION = "particular_chat_notification"
let ALL_CHAT_LIST_NOTIFICATION = "all_chat_notification"

enum MessageType : Int {
    case SENT
    case RECIEVED
}

class Constants: NSObject {
    
}
