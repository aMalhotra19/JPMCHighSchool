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
        VStack {
            NavigationView {
                HighSchoolView(viewModel: viewModel)
                    .navigationTitle("High Schools")
            }
        }
        .onAppear{viewModel.getSchoolData()}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
