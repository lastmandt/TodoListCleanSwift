//
//  OrderedTaskManager.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Предоставляет список заданий, отсортированных по приоритету.
final class OrderedTaskManager: ITaskManager {

	// MARK: - Private Properties

	private let taskManager: ITaskManager

	// MARK: - Lifecycle

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public

	/// Метод возвращает все задачи, отсортированные по приоритету
	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	/// Метод возвращает все завершенные задачи, отсортированные по приоритету
	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	/// Метод возвращает все незавершенные задачи, отсортированные по приоритету
	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	/// Добавление задач
	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}

	// MARK: - Public

	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}

			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}

			if  $0 is RegularTask, $1 is ImportantTask {
				return false
			}

			return true
		}
	}
}
