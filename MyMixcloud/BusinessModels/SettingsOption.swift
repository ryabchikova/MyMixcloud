//
//  SettingsOption.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 08.09.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

enum SettingsOption: Hashable {
    case logout
    case cashing(isOn: Bool)
    case theme
}
