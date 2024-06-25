//
//  ApiKey.swift
//  Gemini Ai
//
//  Created by R92 on 11/06/24.
//

import Foundation

enum APIKey {
 
  static var `default`: String {
    guard let filePath = Bundle.main.path(forResource: "Generative-Ai", ofType: "plist")
    else {
      fatalError("Couldn't find file 'Generative-Ai.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in Generative-Ai.plist")
    }
    if value.starts(with: "_") {
      fatalError(
        "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
      )
    }
    return value
  }
}
