//
//  UDPManagerDelegate.swift
//  udpchat
//
//  Created by Aleksandr Denisenko on 6/15/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import Foundation

protocol UDPManagerDelegate: class {
    func receiveMessage(message: String)
}
