//
//  Helpers.swift
//  udpchat
//
//  Created by Aleksandr Denisenko on 6/16/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import Foundation

class Helper {
    static func currentTime() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date())
    }
}
