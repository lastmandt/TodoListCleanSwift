//
//  LoginWorker.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

public struct LoginDTO {
	var success: Bool
	var login: String
	var password: String
}

/// Протокол для осуществления авторизации
protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

/// Класс для осуществления авторизации
class LoginWorker: ILoginWorker {

	// MARK: - Public

	/// Метод для осуществления авторизации
	func login(login: String, password: String) -> LoginDTO {
		if login == "Admin" && password == "pa$$32!" {

			return LoginDTO( success: true, login: login, password: password)
		} else {

			return LoginDTO(success: false, login: login, password: password)
		}
	}
}
