//
//  RegisterViewController.swift
//  LoginViewCode-Curso
//
//  Created by Lucas Leonardo Freitas on 10/04/23.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    var registerScreen: RegisterScreen?
    
    var auth:Auth?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
    }
}

extension RegisterViewController:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validaTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController: RegisterScreenProtocol{
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        
        guard let register = self.registerScreen else {return}
    
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: {
            (result, error) in
            if error != nil{
                print("Erro ao cadastrar")
            }else {
                print("Sucesso ao cadastrar")
            }
        })
    }
    
    
}
