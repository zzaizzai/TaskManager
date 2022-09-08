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
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                VStack{
                    Text("hello")
                    
                    CustomSegmentedBar()
                        .padding()
                }
            }
        }
        .overlay(alignment: .bottom) {
            Button {
                
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
