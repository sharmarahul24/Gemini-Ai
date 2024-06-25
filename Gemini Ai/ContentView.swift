//
//  ContentView.swift
//  Gemini Ai
//
//  Created b

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State var userpromt = ""
    @State var response = "How Can I help You Today ?"
    @State var isloading = false
    @State private var searchHistory = [SearchEntry]()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: History(searchHistory: $searchHistory)) {
                VStack {
                    Text("History")
                        .padding(.leading, 300)
                        .foregroundColor(.blue)
                }
            }
                Text("Welcome To Gemini AI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.cyan)
                    .padding(.top,40)
                ZStack{
                    ScrollView{
                        Text(response)
                            .font(.headline)
                    }
                    if isloading{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .cyan))
                            .scaleEffect(4)
                        
                    }
                }
                TextField("Ask Anything..",text: $userpromt,axis: .vertical)
                    .lineLimit(5)
                    .font(.title)
                    .padding()
                    .background(Color.cyan.opacity(0.2),in:Capsule())
                    .disableAutocorrection(true)
                    .onSubmit {
                        generateResponse()
                    }
            }
            .padding()
        }
    }
    func generateResponse(){
        isloading = true
        response = ""
        
        Task{
            do{
                let result = try await model.generateContent(userpromt)
                isloading = false
                let newResponse = result.text ?? "No Response Found"
                response = newResponse
                let entry = SearchEntry(prompt: userpromt, response: newResponse, date: Date())
                searchHistory.append(entry)
            }catch{
                isloading = false
                response = "Somthing Went Wrong\n\(error.localizedDescription)"
            }
        }
    }
}

struct SearchEntry: Identifiable {
    let id = UUID()
    let prompt: String
    let response: String
    let date: Date
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
