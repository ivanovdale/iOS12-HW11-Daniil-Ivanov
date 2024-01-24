//
//  LabeledSeparator.swift
//  iOS12-HW11-Daniil Ivanov
//
//  Created by Daniil (work) on 23.01.2024.
//

import UIKit
import SnapKit

class LabeledSeparator: UIStackView {
    private let leftLineView: UIView = {
        let view = UIView()
        return view
    }()
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let rightLineView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupViewStyle()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupLayout()
        setupViewStyle()
    }

    private func setupHierarchy() {
        addArrangedSubview(leftLineView)
        addArrangedSubview(textLabel)
        addArrangedSubview(rightLineView)
    }

    private func setupLayout() {
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftLineView.snp.trailing)
            make.trailing.equalTo(rightLineView.snp.leading)
        }
    }

    private func setupViewStyle() {
        axis = .horizontal
        alignment = .center
        distribution = .fillProportionally
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setText(_ text: String?) {
        textLabel.text = text
    }

    func setColor(_ color: UIColor) {
        leftLineView.backgroundColor = color
        rightLineView.backgroundColor = color
        textLabel.textColor = color
    }

    func setHeight(_ height: CGFloat) {
        leftLineView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        rightLineView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    // TODO: Возможно ли не задавать ширину линий сепаратора?
    // Хочу, чтобы сами растягивались в стеке.
    func setLineWidth(_ width: CGFloat) {
        leftLineView.snp.makeConstraints { make in
            make.width.equalTo(width)
        }
        rightLineView.snp.makeConstraints { make in
            make.width.equalTo(width)
        }
    }
}

