//
//  TaskManager.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Протокол для управления задачами
protocol ITaskManager {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTasks(tasks: [Task])
}

/// Предоставляет список заданий.
final class TaskManager: ITaskManager {

	// MARK: - Private Properties

	private var taskList = [Task]()

	// MARK: - Public

	/// Метод возвращает все задачи
	public func allTasks() -> [Task] {
		taskList
	}

	/// Метод возвращает все завершенные задачи
	public func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}

	/// Метод возвращает все незавершенные задачи
	public func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}

	/// Добавление задачи
	public func addTask(task: Task) {
		taskList.append(task)
	}

	/// Добавление задач
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}

	/// Удаление задачи
	public func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
