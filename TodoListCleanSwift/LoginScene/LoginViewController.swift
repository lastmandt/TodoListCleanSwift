//
//  LoginViewController.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import UIKit

/// Протокол для отображения данных экрана Login
protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

/// Класс для отображения данных экрана Login
class LoginViewController: UIViewController {

	// MARK: - Private Properties
	private var interactor: ILoginInteractor?
//	Ошибка, если объявлять router через протокол
//	Error: Value of type 'any NSObjectProtocol & ILoginRouter' has no member 'viewController'
//	private var router: (NSObjectProtocol & ILoginRouter)?
	private var router: LoginRouter?

	// MARK: - Public Properties

	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFiledPassword: UITextField!

	// MARK: - Actions

	@IBAction func buttonLogin(_ sender: Any) {
		if let email = textFieldLogin.text, let password = textFiledPassword.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		assembly()
	}

	// MARK: - Private

	private func assembly() {
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: self)
		interactor = LoginInteractor(worker: worker, presenter: presenter)
		router = LoginRouter()
		router?.viewController = self
	}
}

extension LoginViewController: ILoginViewController {

	/// Метож по отображению данных
	func render(viewModel: LoginModels.ViewModel) {
		if viewModel.success {
			router?.routeToTodoList(segue: nil)
		} else {
			let	alert = UIAlertController(
				title: "Error",
				message: "Login: \(viewModel.login) or Password: \(viewModel.password) is incorrect",
				preferredStyle: UIAlertController.Style.alert
			)
			let action = UIAlertAction(title: "Ok", style: .default)
			alert.addAction(action)
			present(alert, animated: true, completion: nil)
		}
	}
}
