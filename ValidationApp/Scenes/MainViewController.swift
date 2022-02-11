//
//  MainViewController.swift
//  ValidationApp
//
//  Created by Андрей Моисеев on 11.02.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupReadyButton()
    }
    
    private func setupReadyButton() {
        
        readyButton.layer.cornerRadius = 10.0
        readyButton.addTarget(self, action: #selector(pressReadyButton), for: .touchUpInside)
    }
    
    private func showAlert() {
        
        let alert = UIAlertController(title: "Успех", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupValidation() {
        
        let emailValidator = Validator(strategy: EmailStrategy())
        let email = emailTextField.text ?? ""
        if emailValidator.validate(email) {
            emailTextField.layer.borderWidth = 0
            emailLabel.text = ""
        } else {
            emailTextField.layer.cornerRadius = 3.0
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailLabel.text = "Email должен содержать символы ‘@‘ и ‘.’"
            emailLabel.textColor = .red
        }
        
        let passwordValidator = Validator(strategy: PasswordStratgy())
        let password = passwordTextField.text ?? ""
        if passwordValidator.validate(password) {
            passwordTextField.layer.borderWidth = 0
            passwordLabel.text = ""
        } else {
            passwordTextField.layer.cornerRadius = 3.0
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1.0
            passwordLabel.text = "Пароль должен быть больше 8 символов"
            passwordLabel.textColor = .red
        }
        
        let confirmPassword = confirmPasswordTextField.text ?? ""
        if confirmPassword == password {
            confirmPasswordTextField.layer.borderWidth = 0
            confirmPasswordLabel.text = ""
        } else {
            confirmPasswordTextField.layer.cornerRadius = 3.0
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordTextField.layer.borderWidth = 1.0
            confirmPasswordLabel.text = "Пароль не совпадают"
            confirmPasswordLabel.textColor = .red
        }
        
        if emailValidator.validate(email) && passwordValidator.validate(password) && confirmPassword == password {
            showAlert()
        } else {
            print("Не все поля правильно заполнены")
        }
    }

    @IBAction func pressReadyButton(_ sender: UIButton) {
        
        setupValidation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
