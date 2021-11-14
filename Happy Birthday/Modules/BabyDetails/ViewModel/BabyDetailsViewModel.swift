//
//  BabyDetailsViewModel.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import UIKit

protocol BirthdayScreenDelegate {
    func isButtonEnabled(_ value: Bool)
    func performSegue(withID id: String)
}

class BabyDetailsViewModel {

    // MARK: - Properties
    private let babyDetailsModel: BabyDetailsModel
    private var delegate: BirthdayScreenDelegate?
    private(set)var babyBirthdayViewModel: BabyBirthdayViewModel?
    private(set) var babyBirthdayDate: Date? {
        didSet {
            UserDefaults.set(babyBirthdayDate: babyBirthdayDate)
        }
    }
    
    private(set) var babyName: String? {
        didSet {
            if let name = babyName {
                UserDefaults.set(babyName: name)
            }
        }
    }
    
    // MARK: - Initalizers
    init(babyDetailsModel: BabyDetailsModel, delegate: BirthdayScreenDelegate) {
        self.babyDetailsModel = babyDetailsModel
        self.delegate = delegate
        self.babyBirthdayDate = babyDetailsModel.babyBirthdayDate
        self.babyName = babyDetailsModel.babyName
    }
    
    // MARK: - Computed Properties (Public)
    var babyImage: UIImage? {
        guard let data = UserDefaults.babyImageData else { return nil}
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        return UIImage(data: decoded)
    }
    
    var isEnabledShowBirthdayScreenButton: Bool {
        if babyName?.isEmpty == false, babyBirthdayDate != nil {
            return true
        }
        return false
    }
    
    // MARK: - Functions (Public)
    func babyNameTextFieldChanged(_ text: String?) {
        babyName = text
    }
    
    func babyBirthdayDatePickerChanged(_ date: Date) {
        // Make sure that the baby is at least 1 Months old
        if getBabyAge(from: date) != nil {
            babyBirthdayDate = date
        } else {
            babyBirthdayDate = nil
        }
    }
        
    func showBirthdayScreenButtonTapped() {
        createBabyBirthDayModel()
        delegate?.performSegue(withID: BabyBirthdayViewController.segueIdentifier)
    }
    
    // MARK: - Functions (Private)
    private func getBabyAge(from date: Date) -> (ageType: BabyAgeType, value: Int)? {
        let babyAge = Calendar.current.dateComponents([.year, .month], from: date, to: Date())
        
        if let years = babyAge.year, years > 0 {
            return (ageType: BabyAgeType.years, value: years)
        }
        
        if let months = babyAge.month, months > 0 {
            return (ageType: BabyAgeType.months, value: months)
        }
        
        return nil
    }
    
    private func createBabyBirthDayModel() {
        guard let date = babyBirthdayDate, let babyAge = getBabyAge(from: date), let babyName = babyName else { return }
        let babyModel = BabyBirthdayModel(babyName: babyName, babyAgeType: babyAge.ageType, babyNumberOfUnits: babyAge.value)
        babyBirthdayViewModel = BabyBirthdayViewModel(babyBirthdayModel: babyModel)
    }
}
