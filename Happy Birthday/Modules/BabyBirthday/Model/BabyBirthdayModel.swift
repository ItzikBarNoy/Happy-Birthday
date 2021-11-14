//
//  BabyBirthdayModel.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import Foundation

class BabyBirthdayModel {

    // MARK: - Properties
    var babyName: String
    var babyAgeType: BabyAgeType
    var babyNumberOfUnits: Int
    var babyImageData: Data? = UserDefaults.babyImageData
    
    init(babyName: String, babyAgeType: BabyAgeType, babyNumberOfUnits: Int) {
        self.babyName = babyName
        self.babyAgeType = babyAgeType
        self.babyNumberOfUnits = babyNumberOfUnits
    }
}
