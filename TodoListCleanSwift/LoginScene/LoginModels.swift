//
//  LoginModels.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Enum, описывающий модели VIP цикла для экрана Login
enum LoginModels {
	struct Request {
		var login: String
		var password: String
	}

	struct Response {
		var success: Bool
		var login: String
		var password: String
	}

	struct ViewModel {
		var success: Bool
		var login: String
		var password: String
	}
}
