//
//  BabyDetailsModel.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import Foundation

enum BabyAgeType: String {
    case years, months
}

class BabyDetailsModel {
    
    // MARK: - Properties
    var babyName: String? = UserDefaults.babyName
    var babyBirthdayDate: Date? = UserDefaults.babyBirthdayDate
    var babyImageData: Data? = UserDefaults.babyImageData
}
