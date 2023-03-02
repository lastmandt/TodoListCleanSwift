//
//  TodoListViewController.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import UIKit

/// Протокол для отображения данных экрана TodoList
protocol ITodoListViewController: AnyObject {
	func render(viewModel: TodoListModels.ViewModel)
}

/// Класс для отображения данных экрана TodoList
class TodoListViewController: UITableViewController {

	// MARK: - Private Properties

	private var viewModel: TodoListModels.ViewModel = TodoListModels.ViewModel(tasksBySections: [])
	private var interactor: ITodoListInteractor?

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "TodoList"

		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

		assembly()
		interactor?.viewIsReady()
	}

	// MARK: - Private

	/// Метод по созданию зависимостей VIP цикла
	private func assembly() {
		let presenter = TodoListPresenter(viewController: self)
		let worker = TodoListRepositoryWorker()
		self.interactor = TodoListInteractor(presenter: presenter, repositoryWorker: worker)
	}


	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySections.count
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.tasksBySections[section].title
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewModel.tasksBySections[section]
		return section.tasks.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		var contentConfiguration = cell.defaultContentConfiguration()

		switch taskData {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor:  UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText )
			taskText.append(NSAttributedString(string: task.name))

			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverdue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		}

		cell.tintColor = .red
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(request: TodoListModels.Request(taskIndexPath: indexPath))
	}
}

extension TodoListViewController: ITodoListViewController {

	/// Метод по отображению данных
	func render(viewModel: TodoListModels.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
