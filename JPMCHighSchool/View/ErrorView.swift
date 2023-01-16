//
//  ErrorView.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/15/23.
//

import SwiftUI

struct ErrorView: View {
    var error: String
    var body: some View {
        VStack {
            Image(systemName: Constants.imageError)
                .imageScale(.large)
                .font(.system(size: 52))
                .padding(.bottom, 10)
            Text(error)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: Constants.noData)
    }
}
