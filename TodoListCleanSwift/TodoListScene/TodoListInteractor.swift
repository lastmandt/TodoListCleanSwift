//
//  TodoListInteractor.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Протокол для реализации бизнес логики экрана TodoList
protocol ITodoListInteractor {
	func viewIsReady()
	func didTaskSelected(request: TodoListModels.Request)
}

/// Класс для реализации бизнес логики экрана TodoList
class TodoListInteractor: ITodoListInteractor {

	// MARK: - Private Properties

	private var presenter: ITodoListPresenter?
	private var sectionManager: ISectionForTaskManagerAdapter?

	// MARK: - Lifecycle

	init(presenter: ITodoListPresenter, repositoryWorker: ITodoListRepositoryWorker) {
		self.presenter = presenter
		self.sectionManager = assembly(with: repositoryWorker)
	}

	// MARK: - Public

	/// Метод для подтверждения готовности View и отправки данных для подготовки на отображение
	public func viewIsReady() {
		let response = makeResponse()
		presenter?.present(response: response)
	}

	/// Метод для переключения готовности задачи и отправки данных для подготовки на отображение
	public func didTaskSelected(request: TodoListModels.Request) {
		guard let sectionManager = sectionManager else { return }
		let section = sectionManager.getSection(forIndex: request.taskIndexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[request.taskIndexPath.row]
		task.completed.toggle()
		let response = makeResponse()
		presenter?.present(response: response)
	}

	// MARK: - Private

	private func assembly(with worker: ITodoListRepositoryWorker) -> ISectionForTaskManagerAdapter {
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		taskManager.addTasks(tasks: worker.getTasks())

		return SectionForTaskManagerAdapter(taskManager: taskManager)
	}

	private func makeResponse() -> TodoListModels.Response {
		guard let sectionManager = sectionManager else { return TodoListModels.Response(sections: []) }
		var responseSections = [TodoListModels.Response.Section]()
		for section in sectionManager.getSections() {
			responseSections.append(TodoListModels.Response.Section(
				title: section.title,
				tasks: sectionManager.getTasksForSection(section: section)))
		}

		return TodoListModels.Response(sections: responseSections)
	}

}
