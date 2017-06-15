//
//  ChatMessage.swift
//  udpchat
//
//  Created by Aleksandr Denisenko on 6/15/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import Foundation

struct ChatMessage {
    var time: String!
    var message: String!
    var type: ChatMessageType
}

enum ChatMessageType {
    case incoming
    case outcoming
}
