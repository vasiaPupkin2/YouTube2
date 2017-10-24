//
//  Setting.swift
//  YouTube
//
//  Created by leanid niadzelin on 29.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let titleName: SettingsNames
    let imageName: String
    
    init(titleName: SettingsNames, imageName: String) {
        self.titleName = titleName
        self.imageName = imageName
    }
}

enum SettingsNames: String {
    case cancel = "Cancel"
    case privacy = "Term and privacy"
    case feedback = "Send feedback"
    case help = "Help"
    case switchAccount = "Switch account"
    case set = "Settings"
}

