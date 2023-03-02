//
//  LoginInteractor.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Протокол для реализации бизнес логики экрана Login
protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

/// Класс для реализации бизнес логики экрана Login
class LoginInteractor: ILoginInteractor {

	// MARK: - Private Properties

	private var worker: ILoginWorker
	private var presenter: ILoginPresenter?

	// MARK: - Lifecycle

	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		self.worker = worker
		self.presenter = presenter
	}

	// MARK: - Public

	/// Метод для обработки авторизации и отправки данных для подготовки на отображение
	func login(request: LoginModels.Request) {
		let result = worker.login(login: request.login, password: request.password)

		let response = LoginModels.Response(
			success: result.success,
			login: result.login,
			password: result.password)

		presenter?.present(response: response)
	}
}

