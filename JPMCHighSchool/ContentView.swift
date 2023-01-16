//
//  ContentView.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/14/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HighSchoolViewModel()
    var body: some View {
        NavigationView {
            HighSchoolView(viewModel: viewModel)
                .navigationTitle("High Schools")
                .task{viewModel.getSchoolData()}
                .refreshable {
                    viewModel.getSchoolData()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
