//
//  LabeledSeparator.swift
//  iOS12-HW11-Daniil Ivanov
//
//  Created by Daniil (work) on 23.01.2024.
//

import UIKit
import SnapKit

class LabeledSeparator: UIStackView {

    // MARK: - Outlets

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

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        [
            leftLineView,
            textLabel,
            rightLineView,
        ].forEach { addArrangedSubview($0) }
    }

    private func setupLayout() {

        leftLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        rightLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftLineView.snp.trailing).offset(10)
            make.trailing.equalTo(rightLineView.snp.leading).offset(-10)
        }
    }

    private func setupView() {
        axis = .horizontal
        alignment = .center
        distribution = .equalCentering
    }

    func setText(_ text: String?) {
        textLabel.text = text
    }

    // MARK: - Setters

    func setColor(_ color: UIColor) {
        leftLineView.backgroundColor = color
        rightLineView.backgroundColor = color
        textLabel.textColor = color
    }
}

