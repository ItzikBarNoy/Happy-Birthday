//
//  BabyBirthdayViewModel.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import UIKit

class BabyBirthdayViewModel {
    
    // MARK: - Properties
    var babyBirthdayModel: BabyBirthdayModel
    private let babyBirthdayContents = BabyBirthdayFactory.shared.contents
    
    // MARK: - Initalizers
    init(babyBirthdayModel: BabyBirthdayModel) {
        self.babyBirthdayModel = babyBirthdayModel
    }
    
    // MARK: - Computed Properties (Public)
    var babyNameTitle: String {
        return "TODAY # IS".replacingOccurrences(of: "#", with: babyBirthdayModel.babyName.uppercased())
    }
    
    var numberOfUnitsImage: UIImage {
        return UIImage(named: "\(babyBirthdayModel.babyNumberOfUnits)") ?? UIImage()
    }
    
    var babyImage: UIImage? {
        guard let data = UserDefaults.babyImageData else { return nil}
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        return UIImage(data: decoded)
    }
    
    var unitDescriptionText: String {
        switch babyBirthdayModel.babyAgeType {
        case .months:
            return "MONTH OLD!"
        case .years:
            return "YEARS OLD!"
        }
    }
    
    func getRandomBabyBirthdayContent() -> BabyBirthdayContent? {
        return babyBirthdayContents.randomElement()
    }
}
