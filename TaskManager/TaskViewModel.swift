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

}
