//
//  LoginRouter.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import UIKit

/// Протокол для перехода на экран TodoList
@objc protocol ILoginRouter {
	func routeToTodoList(segue: UIStoryboardSegue?)
}

/// Класс для перехода на экран TodoList
class LoginRouter: NSObject, ILoginRouter {

	// MARK: - Public Properties

	public weak var viewController: LoginViewController?

	// MARK: - Public

	/// Метод для перехода на экран TodoList
	func routeToTodoList(segue: UIStoryboardSegue?) {
		let destinationVC = viewController?.storyboard?.instantiateViewController(
			withIdentifier: "TodoListViewController") as! TodoListViewController
		navigateToTodoList(source: viewController!, destination: destinationVC)
	}

	// MARK: - Navigation

	private func navigateToTodoList(source: LoginViewController, destination: TodoListViewController) {
	  source.show(destination, sender: nil)
	}
}
