//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by 小暮準才 on 2022/09/07.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab : String = "Today"
    
    @Published var openEditTask : Bool = false
    @Published var taskTitle : String = ""
    @Published var taskColor = "Red"
    @Published var taskDeadline : Date = Date()
    @Published var taskType = "Basic"
    @Published var showDatePicker : Bool = false
    
    @Published var editTask: Task?

    
    func addTask(context: NSManagedObjectContext) -> Bool {
        let task = Task(context: context)
        
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isComplete = false
        
        if let _ = try? context.save(){
            return true
        }
        
        return false
        
    }
    
    
    func resetTaskDate(){
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadline = Date()
    }
}
