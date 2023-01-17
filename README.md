# JPMCHighSchool
# Dear Reviewer, Thank you for taking time to review my code.

Listing out the details of the code as below:

Design Pattern: MVVM

Deployment target: 16.2

Device support: iPhone

Coding language/Framework: SwiftUI/Swift/Combine

Details:

* App is a highschool app which fetches data from highschool API
* After getting the result, UI displays list of highschools
* On selection of any highschool in the list, it opens a detail page and displays SAT SCores for that corresponding highschool
* Includes testcase for ViewModel, NetworkManager and NetworkServices

Implementation Details:

# API
* NetworkService, Contains URLSession call. Future implementation to seperate API service in seperate module
* NetworkManager, Contains Service call, JSON data decode, getSchoolData and getScoreData. Future implementation to seperate API service in seperate module

# View
* HighSchoolView to display HighSchool results in list
* ErrorView to display Errors
* SATDetailView, Displays SAT Scores for the selected Highschool

# ViewModel
* HighSchoolViewModel, Contains the initial function to getSchoolData, getScoreData and getScoreData for the input string

# Model
* HighSchool, SATScore Models
