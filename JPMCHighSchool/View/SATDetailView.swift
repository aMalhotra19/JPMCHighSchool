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
                Text(Constants.writingScore)
                Text(score.satWritingAvgScore)
                Spacer()
            }
            HStack {
                Text(Constants.mathScore)
                Text(score.satMathAvgScore)
            }
            HStack {
                Text(Constants.readingScore)
                Text(score.satCriticalReadingAvgScore)
            }
            Spacer()
        }
        .padding(.leading, 20.0)
        .padding(.top, 10.0)
        .navigationTitle(Constants.satScoreTitle)
        .font(.subheadline)
    }
}

struct SATDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SATDetailView(score: SATScore(dbn: "test", schoolName: "High School", numOfSatTestTakers: "200", satCriticalReadingAvgScore: "100", satMathAvgScore: "100", satWritingAvgScore: "100"))
    }
}
