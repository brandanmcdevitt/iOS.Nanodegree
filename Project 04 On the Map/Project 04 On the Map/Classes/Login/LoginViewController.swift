//
//  LoginViewController.swift
//  Project 04 On the Map
//
//  Created by Brandan McDevitt on 01/04/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let session = SessionAPI()
    private let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.backgroundColor = UIColor(white: 0/255, alpha: 0.4)
        spinner.color = .white
        spinner.layer.cornerRadius = 5.0
        view.addSubview(spinner)
        
        spinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func login(_ sender: UIButton) {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            spinner.startAnimating()
            session.postSession(username: email, password: password) { result in
                switch result {
                case .success:
                    self.spinner.stopAnimating()
                    self.performSegue(withIdentifier: "showMain", sender: self)
                case .failure(let error):
                    self.spinner.stopAnimating()
                    let ac = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    ac.addAction(cancel)
                    self.present(ac, animated: true)
                }
            }
        } else {
            print("Missing username/password")
        }
    }
    
    @IBAction func signup(_ sender: UIButton) {
        let link = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")
        UIApplication.shared.open(link!)
    }
}
