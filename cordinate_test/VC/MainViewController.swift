//
//  ViewController.swift
//  cordinate_test
//
//  Created by 최진용 on 2023/04/23.
//

import UIKit
import Combine





class MainViewController: UIViewController, UITextFieldDelegate {
    
    let nameTextField = UITextField()
    let ageTextField = UITextField()
    let occupationTextField = UITextField()
    let confirmButton = UIButton()
    
    var cancleBag = Set<AnyCancellable>()
    var person = CurrentValueSubject<Person, Error>(Person(name: "", age: "", occupation: ""))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        ageTextField.delegate = self
        occupationTextField.delegate = self
        makeUI()
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        setStream()
        personSubscription()
    }
    
    func setStream() {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: nameTextField)
            .compactMap {
                ($0.object as? UITextField)?.text
            }.sink { [weak self] string in
                self?.person.value.name = string
            }.store(in: &cancleBag)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: ageTextField)
            .compactMap {
                ($0.object as? UITextField)?.text
            }.sink { [weak self] string in
                self?.person.value.age = string
            }.store(in: &cancleBag)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: occupationTextField)
            .compactMap {
                ($0.object as? UITextField)?.text
            }.sink { [weak self] string in
                self?.person.value.occupation = string
            }.store(in: &cancleBag)
    }
    
    func personSubscription() {
        person.sink { completion in
            
        } receiveValue: { person in
            print(person)
        }.store(in: &cancleBag)
    }
    
    
    @objc
    func confirm() {
        if person.value.isValid {
            let alert = UIAlertController(title: "입력완료", message: "입력이완료됨", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "입력문제", message: "값을 입력해주세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func makeUI() {
        view.addSubview(nameTextField)
        nameTextField.placeholder = "name"
        nameTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        nameTextField.layer.borderWidth = 1
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(ageTextField)
        ageTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        ageTextField.layer.borderWidth = 1
        ageTextField.placeholder = "age"
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            ageTextField.heightAnchor.constraint(equalToConstant: 30),
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20)
        ])
        view.addSubview(occupationTextField)
        occupationTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        occupationTextField.layer.borderWidth = 1
        occupationTextField.placeholder = "occupation"
        occupationTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            occupationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            occupationTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            occupationTextField.heightAnchor.constraint(equalToConstant: 30),
            occupationTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("confirm", for: .normal)
        confirmButton.backgroundColor = .systemCyan
        NSLayoutConstraint.activate([
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: occupationTextField.bottomAnchor, constant: 50),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }


    
    
}

#if DEBUG
import SwiftUI

struct ViewControllerPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        MainViewController()
    }
}

struct ViewControllerPresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerPresentable()
            .ignoresSafeArea()
    }
}

#endif
