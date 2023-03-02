//
//  SectionForTaskManagerAdapter.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Протокол адаптер  по работе с секциями
protocol ISectionForTaskManagerAdapter {
	func getSections() -> [Section]
	func getTasksForSection(section: Section) -> [Task]
	func getSection(forIndex index: Int) -> Section
}

enum Section: CaseIterable {
	case completed
	case uncompleted

	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

/// Класс адаптер для TaskManager по работе с секциями
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {

	// MARK: - Private Properties

	private let sections: [Section] = [.uncompleted, .completed]
	private let taskManager: ITaskManager

	// MARK: - Lifecycle

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public

	/// Метод возвращает массив существующих секций
	public func getSections() -> [Section] {
		sections
	}

	/// Метод возвращает секцию по индексу
	public func getSection(forIndex index: Int) -> Section {
		let i = min(index, sections.count - 1)

		return sections[i]
	}

	/// Метод возвращает массив задач для секции 
	public func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}
}

