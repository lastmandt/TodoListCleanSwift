//
//  TodoListPresenter.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Протокол для подготовки отображения данных на экране TodoList
protocol ITodoListPresenter {
	func present(response: TodoListModels.Response)
}

/// Класс для подготовки отображения данных на экране TodoList
class TodoListPresenter: ITodoListPresenter {

	// MARK: - Private Properties

	private weak var viewController: ITodoListViewController?

	// MARK: - Lifecycle

	init(viewController: ITodoListViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public

	/// Метод для подготовки отображения данных и передачи их View
	public func present(response: TodoListModels.Response) {
		let viewModel = mapViewModel(from: response)
		viewController?.render(viewModel: viewModel)
	}

	// MARK: - Private

	private func mapViewModel(from response: TodoListModels.Response) -> TodoListModels.ViewModel {
		var sections = [TodoListModels.ViewModel.Section]()
		for section in response.sections {
			let sectionData = TodoListModels.ViewModel.Section(
				title: section.title,
				tasks: mapTasksData(tasks: section.tasks)
			)

			sections.append(sectionData)
		}

		return TodoListModels.ViewModel(tasksBySections: sections)
	}

	private func mapTasksData(tasks: [Task]) -> [TodoListModels.ViewModel.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}

	private func mapTaskData(task: Task) -> TodoListModels.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = TodoListModels.ViewModel.ImportantTask(
				name: task.title,
				isDone: task.completed,
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(TodoListModels.ViewModel.RegularTask(
				name: task.title,
				isDone: task.completed))
		}
	}
}
