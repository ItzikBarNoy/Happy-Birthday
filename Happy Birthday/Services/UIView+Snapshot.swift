//
//  UIView+Snapshot.swift
//  Happy Birthday
//
//  Created by Itzik Isco Bar-Noy on 13/11/2021.
//  Copyright (c) 2021 fluxLoop AS, All rights reserved.
//


import UIKit

extension UIView {
    func takeSnapshot(addViews: [UIView], hideViews: [UIView]) -> UIImage {
        for hideView in hideViews {
            hideView.isHidden = true
        }

        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)

        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        for addView in addViews{
            addView.drawHierarchy(in: addView.frame, afterScreenUpdates: true)
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        for hideView in hideViews {
            hideView.isHidden = false
        }

        return image!
    }
}
