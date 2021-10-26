//
//  Message.swift
//  ChatApp
//
//  Created by Mihailo Jovanovic on 18.10.21..
//

import Foundation

struct Message {
    let sender: String
    let body: String
    let time: String
    init(email:String, text:String, time:String) {
        sender = email
        body = text
        self.time = time
    }
}
