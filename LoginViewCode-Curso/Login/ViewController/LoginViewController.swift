//
//  ViewController.swift
//  LoginViewCode-Curso
//
//  Created by Lucas Leonardo Freitas on 26/03/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var auth:Auth?
    var loginScreen: LoginScreen?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate = self
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

extension LoginViewController: LoginScreenProtocol {
    func actionLoginButton() {
        
        guard let login = self.loginScreen else { return }
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { usuario, error in
            if error !=  nil {
                print("Atençao dados incorretos, verifique e tente novamente!")
            }else{
                
                if usuario == nil {
                    print("Tivemos um problema inesperado, tente novamente mais tarde")
                }else {
                    print("Parabens, usuario logado com sucesso :D !")
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let viewController: RegisterViewController =  RegisterViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validaTextField()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
