//
//  BabyDetailsViewController.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import UIKit

protocol CameraImageServicable where Self: UIViewController, Self: ImageServiceDelegate  {}

class BabyDetailsViewController: UIViewController, CameraImageServicable  {

    // MARK: - Outlets
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var babyNameTextField: UITextField!
    @IBOutlet weak var babyBirthdayDatePicker: UIDatePicker!
    @IBOutlet weak var placeHolderImageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var showBirthdayScreenButton: UIButton!
    
    // MARK: - Properties
    private var viewModel: BabyDetailsViewModel!
    private var cameraImageService: CameraImageService?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register for Gesture Recognizer (to dismiss the keyboard)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // Register to ViewModel services
        viewModel = BabyDetailsViewModel(babyDetailsModel: BabyDetailsModel(), delegate: self)
        
        cameraImageService = CameraImageService(viewController: self)
        configurePage()
        addRandomCirclesViewsToBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configurePlaceHolderImageView()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == BabyBirthdayViewController.segueIdentifier {
            if let viewController = segue.destination as? BabyBirthdayViewController {
                viewController.viewModel = viewModel.babyBirthdayViewModel
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func babyNameTextFieldChanged(_ sender: UITextField) {
        viewModel.babyNameTextFieldChanged(sender.text)
        updateButtonState()
    }
    
    @IBAction func babyBirthdayDatePickerChanged(_ sender: UIDatePicker) {
        viewModel.babyBirthdayDatePickerChanged(sender.date)
        updateButtonState()
    }
    
    @IBAction func photoButtonTapped(_ sender: UIButton) {
        cameraImageService?.showCameraAlertController()
    }
    
    @IBAction func showBirthdayScreenButtonTapped(_ sender: UIButton) {
        viewModel.showBirthdayScreenButtonTapped()
    }
    
    // MARK: - Functions (UI-Configuration)
    private func configurePage() {
        configureAppTitleLabel()
        configureBabyNameTextField()
        configureBabyBirthdayDatePicker()
        configurePlaceHolderImageView()
        configureShowBirthdayScreenButton()
    }
    
    private func configureAppTitleLabel() {
        appTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureBabyNameTextField() {
        babyNameTextField.text = viewModel.babyName
    }
    
    private func configureBabyBirthdayDatePicker() {
        babyBirthdayDatePicker.maximumDate = Date()
        babyBirthdayDatePicker.date = viewModel.babyBirthdayDate ?? Date()
    }
    
    private func configurePlaceHolderImageView() {
        placeHolderImageView.layer.cornerRadius = 10
        placeHolderImageView.image = viewModel.babyImage ?? UIImage.imageIconRotate
    }
    
    private func configureShowBirthdayScreenButton() {
        showBirthdayScreenButton.layer.cornerRadius = showBirthdayScreenButton.frame.height / 2
        updateButtonState()
    }
    
    private func updateButtonState() {
        showBirthdayScreenButton.isEnabled = viewModel.isEnabledShowBirthdayScreenButton
    }
    
    /// This functions create some circular random views, just for making the screen more lovely.
    private func addRandomCirclesViewsToBackground() {
        let numberOfCircles = 45
        let rangeOnTheXaxis = 0...UIScreen.main.bounds.width
        let rangeOnTheYaxis = 0...UIScreen.main.bounds.height
        
        for _ in 0..<numberOfCircles {
            let circleSize = CGFloat([30, 20, 15].randomElement()!)
            let x = CGFloat.random(in: rangeOnTheXaxis)
            let y = CGFloat.random(in: rangeOnTheYaxis)
            let circleView = UIView(frame: CGRect(x: x, y: y, width: circleSize, height: circleSize))
            circleView.backgroundColor = [.tintColor, .cyan, .lightGray, .lightText].randomElement()!
            circleView.layer.cornerRadius = circleView.frame.height / 2
            view.addSubview(circleView)
            view.sendSubviewToBack(circleView)
        }
    }
    
    // MARK: - Functions (General)
    @objc func hideKeyBoard(sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate (Implementaion)
extension BabyDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - BirthdayScreenDelegate (Implementaion)
extension BabyDetailsViewController: BirthdayScreenDelegate {
    func isButtonEnabled(_ value: Bool) {
        showBirthdayScreenButton.isEnabled = value
    }
    
    func performSegue(withID id: String) {
        performSegue(withIdentifier: id, sender: self)
    }
}

// MARK: - ImageServiceDelegate (Implementaion)
extension BabyDetailsViewController: ImageServiceDelegate {
    func updateImage(with image: UIImage) {
        placeHolderImageView.image = image
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.set(babyImageData: encoded)
    }
}
