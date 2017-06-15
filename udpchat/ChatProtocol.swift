//
//  ChatProtocol.swift
//  udpchat
//
//  Created by Aleksandr Denisenko on 6/15/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import Foundation

protocol ChatProtocol: class {
    /// adding message to chatlist
    func addMessage(message: String, type: ChatMessageType)
    
    /// sending message to server
    func sendMessage(message: String, type: ChatMessageType)
}
