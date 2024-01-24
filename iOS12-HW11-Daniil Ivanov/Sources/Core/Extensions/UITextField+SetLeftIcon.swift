//
//  UITextField+setLeftIcon.swift
//  iOS12-HW11-Daniil Ivanov
//
//  Created by Daniil (work) on 22.01.2024.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftIcon(_ image: UIImage, tintColor: UIColor? = nil) {
        let iconView = UIImageView(frame: CGRect(x: 40, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.tintColor = tintColor
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 90, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
