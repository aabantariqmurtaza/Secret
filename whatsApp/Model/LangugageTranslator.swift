//
//  LangugageTranslator.swift
//  whatsApp
//
//  Created by Aaban Tariq on 01/05/2018.
//  Copyright © 2018 Aaban Tariq. All rights reserved.
//

import UIKit


class LangugageTranslator: NSObject {
    
    static var translatedString : String? = nil

    static func fetchRespectiveString(textToTranslate : String, langCode : String){
        
        let currDeviceLangCode = NSLocale.current.languageCode
        let langStr = "\(currDeviceLangCode!)|\(langCode)"
        let langStringEscaped : String = langStr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!;
        let textEscaped : String = textToTranslate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlStr : String = "http://ajax.googleapis.com/ajax/services/language/translate?q=\(textEscaped)&v=1.0&langpair=\(langStringEscaped)"
        let url = URL(string: urlStr)!
        var str_ : String
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments)
                print(str)
                translatedString = "Test"
            } catch {
                print("json error: \(error)")
            }
        }
        task.resume()
    }
    
}
