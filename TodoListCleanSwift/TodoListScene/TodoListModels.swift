//
//  TodoListModels.swift
//  TodoListCleanSwift
//
//  Created by Dmitry Troshkin on 22.02.2023.
//

import Foundation

/// Enum, описывающий модели VIP цикла для экрана TodoList
enum TodoListModels {
	struct Request {
		var taskIndexPath: IndexPath
	}

	struct Response {
		let sections: [Section]
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
	}

	struct ViewModel {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}

		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadLine: String
			let priority: String
		}

		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}

		struct Section {
			let title: String
			let tasks: [Task]
		}

		let tasksBySections: [Section]
	}
}
