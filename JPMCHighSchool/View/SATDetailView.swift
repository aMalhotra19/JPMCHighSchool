//
//  SATDetailView.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/15/23.
//

import SwiftUI

struct SATDetailView: View {
    var score: SATScore
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(score.schoolName)
                    .font(.title3)
                Spacer()
            }
            HStack {
                Text("Reading Score: ")
                Text(score.satWritingAvgScore)
                Spacer()
            }
            HStack {
                Text("Math Score: ")
                Text(score.satMathAvgScore)
            }
            HStack {
                Text("Writing Score: ")
                Text(score.satCriticalReadingAvgScore)
            }
            Spacer()
        }
        .padding(.leading, 20.0)
        .padding(.top, 10.0)
        .navigationTitle("SAT Score")
        .font(.subheadline)
    }
}

struct SATDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SATDetailView(score: SATScore(dbn: "jbjhb", schoolName: "High Scholl", numOfSatTestTakers: "200", satCriticalReadingAvgScore: "100", satMathAvgScore: "100", satWritingAvgScore: "100"))
    }
}
