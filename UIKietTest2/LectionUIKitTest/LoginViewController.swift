//
//  LoginViewController.swift
//  LectionUIKitTest
//
//  Created by Konstantin Polin on 31/10/2019.
//  Copyright © 2019 Konstantin Polin. All rights reserved.
//

import UIKit

private enum Consts {
	static let loginFirstName: String = ""
	static let loginSurName: String = ""
}

class LoginViewController: UIViewController {

	@IBOutlet private var nameText: UITextField!
	@IBOutlet private var surnameText: UITextField!
	@IBOutlet private var loginButton: UIButton!
	@IBOutlet private var restoreButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
        
		configureViews()
		configureConstraints()
	}

	private func configureViews() {
		nameText.delegate = self
		surnameText.delegate = self

		nameText.translatesAutoresizingMaskIntoConstraints = false
		surnameText.translatesAutoresizingMaskIntoConstraints = false
		loginButton.translatesAutoresizingMaskIntoConstraints = false
		restoreButton.translatesAutoresizingMaskIntoConstraints = false
	}

	private func configureConstraints() {

		NSLayoutConstraint.activate([
			surnameText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
			surnameText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),

			surnameText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 20),

			nameText.leftAnchor.constraint(equalTo: surnameText.leftAnchor),
			nameText.rightAnchor.constraint(equalTo: surnameText.rightAnchor),

			loginButton.topAnchor.constraint(equalTo: surnameText.bottomAnchor, constant: 20),

			loginButton.leftAnchor.constraint(equalTo: surnameText.leftAnchor),
			loginButton.rightAnchor.constraint(equalTo: surnameText.rightAnchor),
			loginButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

			restoreButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),

			restoreButton.leftAnchor.constraint(equalTo: loginButton.leftAnchor),
			restoreButton.rightAnchor.constraint(equalTo: loginButton.rightAnchor)
		])
	}

	@IBAction private func onLoginTapped(_ sender: Any) {
		guard let name = nameText.text, let surname = surnameText.text else {
			return
		}

		if name == Consts.loginFirstName, surname == Consts.loginSurName {
			performSegue(withIdentifier: "ShowList", sender: self)
		} else {
			showIncorrectNameError()
		}
	}

	private func showIncorrectNameError() {
		let alertController = UIAlertController(
			title: "ERROR!!!",
			message: "Your write incorrect name. Please write correct name",
			preferredStyle: .alert)

		alertController.addAction(UIAlertAction(
			title: "Close",
			style: .default,
			handler: { _ in
				alertController.dismiss(animated: true, completion: nil)
		}))

		present(alertController, animated: true, completion: nil)

		//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
		//                alertController.dismiss(animated: true, completion: nil)
		//            }
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)

		if let imageVC = segue.destination as? ImageViewController {
			let name = nameText.text ?? ""
			let surname = surnameText.text ?? ""

			imageVC.name = name
			imageVC.surname = surname
		}
	}
}

extension LoginViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
