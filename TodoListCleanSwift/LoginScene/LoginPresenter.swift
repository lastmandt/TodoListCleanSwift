//
//  LoginPresenter.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Протокол для подготовки отображения данных на экране Login
protocol ILoginPresenter {
	func present(response: LoginModels.Response)
}

/// Класс для подготовки отображения данных на экране Login
class LoginPresenter: ILoginPresenter {

	// MARK: - Private Properties

	private weak var viewController: ILoginViewController?

	// MARK: - Lifecycle

	init(viewController: ILoginViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public

	/// Метод для подготовки отображения данных и передачи их View
	public func present(response: LoginModels.Response) {
		let viewModel = LoginModels.ViewModel(
			success: response.success,
			login: response.login,
			password: response.password
		)

		viewController?.render(viewModel: viewModel)
	}
}
