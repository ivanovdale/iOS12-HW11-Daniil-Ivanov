//
//  UIView+ApplyGradient.swift
//  iOS12-HW11-Daniil Ivanov
//
//  Created by Daniil (work) on 23.01.2024.
//

import UIKit

extension UIView {
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, cornerRadius: CGFloat = 0) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = cornerRadius
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradient, at: 0)
        layer.masksToBounds = true
    }
}
