//
//  BabyBirthdayFactory.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import UIKit

struct BabyBirthdayContent {
    let backgroundColor: UIColor
    let backgroundImage: UIImage
    let placeHolderImage: UIImage
    let placeHolderBorderColor: UIColor
    let cameraIconButton: UIButton
}

class BabyBirthdayFactory {
    
    // MARK: - Properties
    static let shared = BabyBirthdayFactory()
    private(set) var contents = [BabyBirthdayContent]()
    
    // MARK: - Initializers
    private init() {
        setBabyBirthdayContentArray()
    }
    
    // MARK: - Functions
    private func setBabyBirthdayContentArray() {
        let blueButton = UIButton(type: .custom)
        blueButton.setImage(UIImage.cameraIconBlue, for: .normal)
        let blueContent = BabyBirthdayContent(
            backgroundColor: UIColor.lightBlueGrey1,
            backgroundImage: UIImage.iOsBgPelican,
            placeHolderImage: UIImage.defaultPlaceHolderBlue,
            placeHolderBorderColor: UIColor.lightTeal,
            cameraIconButton: blueButton)
        
        let greenButton = UIButton(type: .custom)
        greenButton.setImage(UIImage.cameraIconGreen, for: .normal)
        let greenContent = BabyBirthdayContent(
            backgroundColor: UIColor.lightBlueGrey2,
            backgroundImage: UIImage.iOsBgFox,
            placeHolderImage: UIImage.defaultPlaceHolderGreen,
            placeHolderBorderColor: UIColor.paleTeal,
            cameraIconButton: greenButton)
        
        let yellowButton = UIButton(type: .custom)
        yellowButton.setImage(UIImage.cameraIconYellow, for: .normal)
        let yellowContent = BabyBirthdayContent(
            backgroundColor: UIColor.pale,
            backgroundImage: UIImage.iOsBgElephant,
            placeHolderImage: UIImage.defaultPlaceHolderYellow,
            placeHolderBorderColor: UIColor.goldenYellow,
            cameraIconButton: yellowButton)
        
        contents = [blueContent, greenContent, yellowContent]
    }
}
