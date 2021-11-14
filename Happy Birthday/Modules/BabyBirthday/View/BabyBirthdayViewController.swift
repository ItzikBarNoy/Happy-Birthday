//
//  BabyBirthdayViewController.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import UIKit

class BabyBirthdayViewController: UIViewController, CameraImageServicable  {
    
    // MARK: - Outlets
    @IBOutlet weak var babyNameLabel: UILabel!
    @IBOutlet weak var numberOfUnitsImageView: UIImageView!
    @IBOutlet weak var unitDescriptionLabel: UILabel!
    @IBOutlet weak var placeHolderImageView: UIImageView!
    @IBOutlet weak var shareTheNewsButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Properties
    private var cameraImageService: CameraImageService?
    static let segueIdentifier = "babyBirthdaySegue"
    var cameraIconButton: UIButton!
    var viewModel: BabyBirthdayViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraImageService = CameraImageService(viewController: self)
        setupUI()
        configurePage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placeHolderImageView.layer.cornerRadius = placeHolderImageView.frame.height / 2
        getCameraIconPosition()
    }
    
    // MARK: - Actions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareTheNewsButtonTapped(_ sender: UIButton) {
        let imageToShare = view.takeSnapshot(addViews: [], hideViews: [closeButton, cameraIconButton, shareTheNewsButton])
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func cameraIconButtonTapped(sender: UIButton) {
        placeHolderImageView.contentMode = .scaleToFill
        cameraImageService?.showCameraAlertController()
    }
    
    // MARK: - Functions
    private func configurePage() {
        shareTheNewsButton.layer.cornerRadius = shareTheNewsButton.frame.height / 2
        placeHolderImageView.layer.borderWidth = 8

        guard let babyBirthdayContent = viewModel.getRandomBabyBirthdayContent() else { return }
        view.backgroundColor = babyBirthdayContent.backgroundColor
        backgroundImageView.image = babyBirthdayContent.backgroundImage
        placeHolderImageView.image = viewModel.babyImage ?? babyBirthdayContent.placeHolderImage
        placeHolderImageView.layer.borderColor = babyBirthdayContent.placeHolderBorderColor.cgColor
        cameraIconButton = babyBirthdayContent.cameraIconButton
    }
    
    private func setupUI() {
        babyNameLabel.text = viewModel.babyNameTitle 
        numberOfUnitsImageView.image = viewModel.numberOfUnitsImage
        unitDescriptionLabel.text = viewModel.unitDescriptionText
        view.sendSubviewToBack(placeHolderImageView)
        view.bringSubviewToFront(closeButton)
    }
  
    private func getCameraIconPosition() {
        let radius = placeHolderImageView.frame.height / 2
        let centerX = placeHolderImageView.center.x
        let centerY = placeHolderImageView.center.y
        let x = centerX + radius * CGFloat(cos(45.0))
        let y = centerY - radius * CGFloat(sin(45.0))
        cameraIconButton.addTarget(self, action: #selector(cameraIconButtonTapped), for: .touchUpInside)
        cameraIconButton.frame = CGRect(x: x, y: y, width: 36, height: 36)
        cameraIconButton.imageView?.contentMode = .scaleAspectFit
        view.addSubview(cameraIconButton)
    }
}

// MARK: - ImageServiceDelegate (Implementaion)
extension BabyBirthdayViewController: ImageServiceDelegate {
    func updateImage(with image: UIImage) {
        placeHolderImageView.image = image
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.set(babyImageData: encoded)
    }
}
