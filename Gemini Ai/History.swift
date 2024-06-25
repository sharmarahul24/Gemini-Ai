//
//  History.swift
//  Gemini Ai
//
//  Created by R92 on 25/06/24.
//

import SwiftUI

struct History: View {
    
    @Binding var searchHistory: [SearchEntry]
    
    var body: some View {
        VStack {
            List(searchHistory) { entry in
                VStack(alignment: .leading) {
                    Text(entry.prompt)
                        .font(.headline)
                    Text(entry.response)
                        .font(.subheadline)
                    Text(entry.date, style: .date)
                        .font(.footnote)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Search History")
        }
    }
}

