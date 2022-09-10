//
//  MainView.swift
//  TaskManager
//
//  Created by 小暮準才 on 2022/09/07.
//

import SwiftUI

struct MainView: View {
    @StateObject var taskModel : TaskViewModel = .init()
    @Namespace var animation
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    
    @Environment(\.self) var env
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                VStack{
                    Text("hello")
                    
                    CustomSegmentedBar()
                        .padding()
                    
                    
                    TaskView()
                }
            }
        }
        .overlay(alignment: .bottom) {
            Button {
                taskModel.openEditTask.toggle()
                
            } label: {
                Label{
                    Text("Add Task")
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding()
                .background(.black, in: Capsule())
            }
            


        }
        .fullScreenCover(isPresented: $taskModel.openEditTask) {
            taskModel.resetTaskDate()
        } content: {
            AddNewTask()
                .environmentObject(taskModel)
        }

    }
    
    @ViewBuilder
    func TaskView() -> some View {
        LazyVStack{
            ForEach(tasks){ task in
                TaskRowView(task: task)
                
            }
        }
        
    }
    @ViewBuilder
    func TaskRowView(task: Task) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            
            
            //show type
            HStack{
                Text(task.type ?? "")
                    .font(.callout)
                    .padding()
                    .background {
                        Capsule()
                            .fill(.gray.opacity(0.3))
                    }
                

                
                Spacer()
                
                
                //edit button for non completed tasks
                if !task.isComplete{
                    Button {
                        taskModel.editTask = task
                        taskModel.openEditTask = true
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                    }

                }
            }
            
            Text(task.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical, 10)
            
            HStack(alignment: .bottom, spacing: 0) {
                
                //show time
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                        
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                if !task.isComplete {
                    Button {
                        task.isComplete.toggle()
                        try? env.managedObjectContext.save()
                    } label: {
                        Circle()
                            .strokeBorder(.black, lineWidth: 1.5)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                    }

                }
                
                
                
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? "Yellow"))
        }
        
    }
    
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Today", "Upcoming", "Task Done"]
        
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .foregroundColor(taskModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background{
                        if taskModel.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                                
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            taskModel.currentTab = tab
                        }
                    }
                    
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
