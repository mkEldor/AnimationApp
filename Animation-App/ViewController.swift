//
//  ViewController.swift
//  Animation-App
//
//  Created by Eldor Makkambaev on 01.05.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import UIKit
import UIKit


extension ViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}

class ViewController: UIViewController {
    let transition = AnimationTransition()
    @objc func handleLogin(){
        print(123)
        let navigationController = UINavigationController.init(rootViewController: SecondViewController())
        navigationController.transitioningDelegate = self
        present(navigationController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topLabel.alpha = 0
        loginButton.alpha = 0
        setupAnimations()
    }
    
    private func setupAnimations(){
        emailTextField.transform = CGAffineTransform.init(translationX: -1000, y: passwordTextField.frame.maxY)
        passwordTextField.transform = CGAffineTransform.init(translationX: 1000, y: passwordTextField.frame.maxY)
        
        UIView.transition(with: emailTextField, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.emailTextField.transform = CGAffineTransform.init(translationX: 0, y: self.emailTextField.frame.maxY)
            self.passwordTextField.transform = CGAffineTransform.init(translationX: 0, y: self.passwordTextField.frame.maxY)
            
        }) { (_) in
            
            UIView.animate(withDuration: 1, animations: {
                self.loginButton.alpha = 1
                self.topLabel.alpha = 1
                
                
            }, completion: nil)
            
        }
    }
    
    
    
    
    
    let inputViews: UIView = {
        let view = UIView()
        //view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage.init(named: "background")
        return imageView
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Animation"
        return label
    }()
    
    var mainView: UIView {
        return view
    }
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        let paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.rightView = paddingView
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        let paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.rightView = paddingView
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    private func setupViews(){
        view.addSubview(backgroundImageView)
        view.addSubview(darkView)
        view.addSubview(topLabel)
        view.addSubview(inputViews)
        view.addSubview(loginButton)
        
        
        inputViews.addSubview(emailTextField)
        inputViews.addSubview(passwordTextField)
        
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        darkView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.bottomAnchor.constraint(equalTo: inputViews.topAnchor, constant: -30).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        inputViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        inputViews.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputViews.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: inputViews.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputViews.topAnchor, constant: 20).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputViews.widthAnchor, multiplier: 0.8).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.centerXAnchor.constraint(equalTo: inputViews.centerXAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: inputViews.bottomAnchor, constant: -20).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputViews.widthAnchor, multiplier: 0.8).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: inputViews.bottomAnchor, constant: 30).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: inputViews.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputViews.widthAnchor, multiplier: 0.6).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        
    }
}


