//
//  ContentView.swift
//  TaskManager
//
//  Created by 小暮準才 on 2022/09/07.
//

import SwiftUI

struct ContentView: View {


    var body: some View {
        NavigationView {
            MainView()
                .navigationBarTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
