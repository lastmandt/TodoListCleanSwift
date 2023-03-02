//
//  TodoListRepositoryWorker.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Протокол для создания данных -> задач
protocol ITodoListRepositoryWorker {
	func getTasks() -> [Task]
}

/// Класс для создания данных -> задач
class TodoListRepositoryWorker: ITodoListRepositoryWorker {

	// MARK: - Public

	/// Метод для создания данных -> задач
	public func getTasks() -> [Task] {
		[ImportantTask(title: "Do homework", taskPriority: .high),
			RegularTask(title: "Do Workout", completed: true),
			ImportantTask(title: "Write new tasks", taskPriority: .low),
			RegularTask(title: "Solve 3 algorithms"),
			ImportantTask(title: "Go shopping", taskPriority: .medium)]
	}
}
