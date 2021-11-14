//
//  UserDefaults+Extension.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import Foundation

extension UserDefaults {

    // MARK: - Constants
    struct Keys {
        static let babyName = "BABY_NAME"
        static let babyBirthdayDate = "BABY_BIRTHDAY_DATE"
        static let babyImage = "BABY_IMAGE"
    }
    
    // MARK: - Class computed properties
    class var babyName: String? {
        return standard.string(forKey: Keys.babyName)
    }
    
    class var babyBirthdayDate: Date? {
        return standard.value(forKey: Keys.babyBirthdayDate) as? Date
    }
    
    class var babyImageData: Data? {
        return standard.data(forKey: Keys.babyImage)
    }
    
    // MARK: - Class functions
    class func set(babyName: String) {
        standard.set(babyName, forKey: Keys.babyName)
    }
    
    class func set(babyBirthdayDate: Date?) {
        standard.set(babyBirthdayDate, forKey: Keys.babyBirthdayDate)
    }
    
    class func set(babyImageData: Data) {
        standard.set(babyImageData, forKey: Keys.babyImage)
    }
}
