//
//  AddNewTask.swift
//  TaskManager
//
//  Created by 小暮準才 on 2022/09/08.
//

import SwiftUI

struct AddNewTask: View {
    
    @EnvironmentObject var taskModel : TaskViewModel
    
    @Environment(\.self) var env
    @Namespace var animation
    
    var body: some View {
        VStack{
            Text("Edit Task")
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading)  {
                    Button {
                        env.dismiss()
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                            
                    }

                    
                }
            
            VStack(alignment: .leading) {
                Text("Task Color")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                let colors: [String] = ["Yellow", "Green", "Blue" , "Purple", "Red" , "Orange"]
                
                HStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25, height: 25)
                            .background(content: {
                                if taskModel.taskColor == color {
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-5)
                                }
                            })
                            .contentShape(Circle())
                            .onTapGesture {
                                taskModel.taskColor = color
                            }
                    }
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Task Deadline")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
                Text(taskModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + ", " + taskModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }

                
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
                TextField("", text: $taskModel.taskTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
            }
            
            Divider()
            
            let taskTypes: [String] = ["Basic", "Urgent", "Important"]
            
            VStack(alignment: .leading) {
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack{
                    ForEach(taskTypes, id: \.self){ type in
                        Text(type)
                            .font(.callout)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(taskModel.taskType == type ? .white : .black)
                            .background {
                                if taskModel.taskType == type {
                                    Capsule()
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                } else {
                                    Capsule()
                                        .strokeBorder(.black)
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation {
                                    taskModel.taskType = type
                                }
                            }
                    }
                }
            }
            .padding(.top, 8)
            
            Divider()
            
            Button {
                
            } label: {
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }

            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}