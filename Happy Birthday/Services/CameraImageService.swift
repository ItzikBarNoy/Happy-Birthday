//
//  CameraImageService.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import UIKit
import MobileCoreServices

protocol ImageServiceDelegate {
    func updateImage(with image: UIImage)
}

/// This class serves as a service, that takes care of selecting an image from the gallery or taking an image through the device camera.
class CameraImageService: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    private let viewController: UIViewController!
    private let imageDelegate: ImageServiceDelegate!
    
    // MARK: - Initializers
    init(viewController: CameraImageServicable) {
        self.viewController = viewController
        imageDelegate = viewController
    }
    
    // MARK: - Functions
    func showCameraAlertController() {
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        imageDelegate.updateImage(with: image)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
