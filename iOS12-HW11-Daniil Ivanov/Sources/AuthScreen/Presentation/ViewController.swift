//
//  ViewController.swift
//  iOS12-HW11-Daniil Ivanov
//
//  Created by Daniil (work) on 21.01.2024.
//

import UIKit
import SnapKit

// MARK: - Constants

fileprivate enum TextConstants {
    static let login = "Login"
    static let usernamePlaceholder = "keanureeves01"
    static let passwordPlaceholder = "Password"
    static let forgotPasswordText = "Forgot your password?"
    static let connectWith = "or connect with"
    static let facebook = "Facebook"
    static let twitter = "Twitter"
    static let dontHaveAccount = "Don't have account?"
    static let signUp = "Sign up"
}

fileprivate enum StyleConstants {
    static let textFieldAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.lightGray,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: LayoutConstants.textFieldFontSize),
    ]
    static let loginLabelFont = UIFont.systemFont(ofSize: LayoutConstants.loginLabelFontSize, weight: UIFont.Weight.bold)
    static let loginButtonGradientColors = [
        UIColor(red: 106 / 255, green: 123 / 255, blue: 213 / 255 , alpha: 1),
        UIColor(red: 106 / 255, green: 115 / 255, blue: 205 / 255, alpha: 1),
    ]
    static let connectWithFacebookButtonColor = UIColor(red: 54 / 255, green: 164 / 255, blue: 239 / 255 , alpha: 1)
    static let connectWithTwitterButtonColor = UIColor(red: 84 / 255, green: 113 / 255, blue: 179 / 255 , alpha: 1)
}

fileprivate enum LayoutConstants {
    static let backgroundTopVectorBottomMargin = 1.45
    static let backgroundBottomVectorBottomMargin = 1.01
    static let mainStackMargin = UIEdgeInsets(top: 40, left: 0, bottom: 1.05, right: 0)
    static let loginStackMargin = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
    static let loginLabelFontSize = 26.0
    static let loginLabelBottomPadding = 0.05
    static let textFieldHeight = 55.0
    static let textFieldCornerRadius = textFieldHeight / 2
    static let textFieldFontSize = 12.0
    static let usernameTextFieldBottomPadding = 20.0
    static let passwordTextFieldBottomPadding = 60.0
    static let loginButtonHeight = textFieldHeight
    static let loginButtonCornerRadius = textFieldCornerRadius
    static let loginButtonBottomPadding = 24.0
    static let dividerHeight = 1.0
    static let dividerOffset = 5.0
    static let connectWithDividerBottomOffset = 30.0
    static let connectWithButtonHeight = 40.0
    static let connectWithButtonCornerRadius = connectWithButtonHeight / 2
    static let connectWithButtonFontSize = 14.0
    static let connectWithIconSize = CGSize(width: connectWithButtonHeight / 2, height: connectWithButtonHeight / 2)
    static let connectWithButtonsSpacing = 20.0
    static let connectWithStackMargin = UIEdgeInsets(top: 0, left: 22, bottom: 50, right: 22)
    static let signUpStackOffset = 50.0
    static let signUpStackSpacing = 8.0
    static let signUpFontSize = 14.0
}

final class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets

    private lazy var backgroundTopVectorView: UIImageView = {
        let view = UIImageView();
        let vector = UIImage(named: "Vector1");
        view.image = vector;

        return view
    }()

    private lazy var backgroundBottomVectorView: UIImageView = {
        let view = UIImageView();
        let vector = UIImage(named: "Vector2");
        view.image = vector;

        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()

    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.login
        label.textColor = .white
        label.textAlignment = .center
        label.font = StyleConstants.loginLabelFont

        return label
    }()

    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: TextConstants.usernamePlaceholder,
            attributes: StyleConstants.textFieldAttributes
        )
        textField.textColor = .gray
        textField.backgroundColor = .white
        textField.layer.cornerRadius = LayoutConstants.textFieldCornerRadius
        textField.clipsToBounds = true
        textField.tag = 0
        textField.returnKeyType = .next
        textField.delegate = self

        guard let leftIcon = UIImage(systemName: "person") else { return textField }
        textField.setLeftIcon(leftIcon, tintColor: .lightGray)

        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: TextConstants.passwordPlaceholder,
            attributes: StyleConstants.textFieldAttributes
        )
        textField.textColor = .gray
        textField.backgroundColor = .white
        textField.layer.cornerRadius = LayoutConstants.textFieldCornerRadius
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.tag = 1
        textField.returnKeyType = .done
        textField.delegate = self

        guard let leftIcon = UIImage(systemName: "lock") else { return textField }
        textField.setLeftIcon(leftIcon, tintColor: .lightGray)

        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextConstants.login, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = LayoutConstants.loginButtonCornerRadius
        button.clipsToBounds = true

        setButtonShadow(for: button)

        return button
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextConstants.forgotPasswordText, for: .normal)

        return button
    }()

    private lazy var spacer: UIView = {
        let spacer = UIView()
        let spacerWidthConstraint = spacer.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
        spacerWidthConstraint.priority = .defaultLow
        spacerWidthConstraint.isActive = true

        return spacer
    }()

    private lazy var connectWithStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()

    private lazy var connectWithDivider: UIStackView = {
        let labeledSeparator = LabeledSeparator()
        labeledSeparator.setText(TextConstants.connectWith)
        labeledSeparator.setColor(.lightGray)

        return labeledSeparator
    }()

    private lazy var connectionOptionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutConstants.connectWithButtonsSpacing

        return stackView
    }()

    private lazy var connectWithFacebookButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextConstants.facebook, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: LayoutConstants.connectWithButtonFontSize)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = LayoutConstants.connectWithButtonCornerRadius
        button.clipsToBounds = true
        button.backgroundColor = StyleConstants.connectWithFacebookButtonColor

        guard let image = UIImage(named: "FacebookLogo")?
            .resized(targetSize: LayoutConstants.connectWithIconSize) else { return button }
        button.setImage(image, for: .normal)

        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = LayoutConstants.connectWithIconSize.height / 2
        button.configuration = configuration

        setButtonShadow(for: button)

        return button
    }()

    private lazy var connectWithTwitterButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextConstants.twitter, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: LayoutConstants.connectWithButtonFontSize)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = LayoutConstants.connectWithButtonCornerRadius
        button.clipsToBounds = true
        button.backgroundColor = StyleConstants.connectWithTwitterButtonColor

        guard let image = UIImage(named: "TwitterLogo")?
            .resized(targetSize: LayoutConstants.connectWithIconSize) else { return button }
        button.setImage(image, for: .normal)

        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = LayoutConstants.connectWithIconSize.height / 2
        button.configuration = configuration

        setButtonShadow(for: button)

        return button
    }()

    private lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = LayoutConstants.signUpStackSpacing

        return stackView
    }()

    private lazy var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.dontHaveAccount
        label.font = UIFont.systemFont(ofSize: LayoutConstants.signUpFontSize)
        label.textColor = .lightGray
        label.textAlignment = .right

        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextConstants.signUp, for: .normal)
        button.setTitleColor(StyleConstants.connectWithTwitterButtonColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: LayoutConstants.signUpFontSize)
        button.contentHorizontalAlignment = .left

        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        setupLoginButtonGradient()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        [
            backgroundBottomVectorView,
            backgroundTopVectorView,
            mainStackView,
        ].forEach { view.addSubview($0) }

        let mainStackViews = [
            loginStackView,
            spacer,
            connectWithStackView,
            signUpStackView,
        ]
        mainStackViews.forEach {
            mainStackView.addArrangedSubview($0)
        }

        let loginStackViews = [
            loginLabel,
            usernameTextField,
            passwordTextField,
            loginButton,
            forgotPasswordButton,
        ]
        loginStackViews.forEach {
            loginStackView.addArrangedSubview($0)
        }

        let connectWithStackViews = [
            connectWithDivider,
            connectionOptionsStackView,
        ]
        connectWithStackViews.forEach {
            connectWithStackView.addArrangedSubview($0)
        }

        let connectionOptionsStackViews = [
            connectWithFacebookButton,
            connectWithTwitterButton,
        ]
        connectionOptionsStackViews.forEach {
            connectionOptionsStackView.addArrangedSubview($0)
        }

        let signUpStackViews = [
            dontHaveAccountLabel,
            signUpButton
        ]
        signUpStackViews.forEach {
            signUpStackView.addArrangedSubview($0)
        }
    }

    private func setupLayout() {

        // MARK: Background

        backgroundTopVectorView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(view)
                .dividedBy(LayoutConstants.backgroundTopVectorBottomMargin)
        }

        backgroundBottomVectorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(backgroundTopVectorView.snp.bottom)
                .dividedBy(LayoutConstants.backgroundBottomVectorBottomMargin)
        }

        // MARK: Main stack

        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstants.mainStackMargin.top)
            make.bottom.equalTo(view).dividedBy(LayoutConstants.mainStackMargin.bottom)
        }

        // MARK: Login stack

        loginStackView.setCustomSpacing(
            view.frame.size.height * LayoutConstants.loginLabelBottomPadding,
            after: loginLabel
        )

        loginStackView.setCustomSpacing(
            LayoutConstants.usernameTextFieldBottomPadding,
            after: usernameTextField
        )

        loginStackView.setCustomSpacing(
            LayoutConstants.passwordTextFieldBottomPadding,
            after: passwordTextField
        )

        loginStackView.setCustomSpacing(
            LayoutConstants.loginButtonBottomPadding,
            after: loginButton
        )

        // MARK: Login stack views

        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.textFieldHeight)
        }

        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.textFieldHeight)
        }

        loginButton.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.loginButtonHeight)
        }

        // MARK: Connect with view

        connectWithStackView.snp.makeConstraints { make in
            make.left.equalTo(view).inset(LayoutConstants.connectWithStackMargin.left)
            make.right.equalTo(view).inset(LayoutConstants.connectWithStackMargin.right)
        }

        mainStackView.setCustomSpacing(LayoutConstants.connectWithStackMargin.bottom, after: connectWithStackView)

        connectWithStackView.setCustomSpacing(
            LayoutConstants.connectWithDividerBottomOffset,
            after: connectWithDivider
        )

        // MARK: Sign up stack

        connectWithFacebookButton.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.connectWithButtonHeight)
        }

        connectWithTwitterButton.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.connectWithButtonHeight)
        }
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupLoginButtonGradient() {
        loginButton.applyGradient(
            colours: StyleConstants.loginButtonGradientColors,
            locations: [0.0, 1.0],
            cornerRadius: LayoutConstants.loginButtonCornerRadius
        )
    }

    // TODO: Почему-то у loginButton тень не работает...
    private func setButtonShadow(for button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

#Preview {
    ViewController()
}
