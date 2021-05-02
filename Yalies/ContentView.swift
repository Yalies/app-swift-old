//
//  ContentView.swift
//  Yalies
//
//  Created by Tiger J. Wang on 3/28/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var peopleLoader = PeopleLoader()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                SearchBar { searchText in
                    peopleLoader.loadPeople(keyword: searchText)
                }
                .padding()
                
                if peopleLoader.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(peopleLoader.people, id: \.self) { person in
                            PersonTile(person: person)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .resignKeyboardOnDragGesture()
        }
    }
}
