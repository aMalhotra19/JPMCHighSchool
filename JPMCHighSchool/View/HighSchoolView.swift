//
//  HighSchoolView.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/15/23.
//

import SwiftUI

struct HighSchoolView: View {
    @ObservedObject var viewModel: HighSchoolViewModel
    var body: some View {
        List {
            ForEach(viewModel.schools, id: \.dbn) { school in
                NavigationLink {
                    SATDetailView(school: school, viewModel: viewModel)
                } label: {
                    Text(school.schoolName)
                }
            }
        }
        .overlay(overlayView)
        .padding(.bottom, 20)
    }
    
    // cases handler fetching data
    @ViewBuilder
    private var overlayView: some View {
        switch viewModel.schoolState {
            // Display loading indicator during API call
        case .loading:
            ProgressView()
            
            // Success with no results
        case .success where viewModel.schools.isEmpty:
            ErrorView(error: Constants.noData)
            
            // Fail with error
        case .failure(let error):
            ErrorView(error: error.localizedDescription)
            
            //Success with data
        default: EmptyView()
        }
    }
}

