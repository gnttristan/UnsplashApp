//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Tristan GINET on 1/23/24.
//

import Foundation
import SwiftUI

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashModel] = []

    
    func fetchHomeFeed() async {
        let url = feedUrl()!

        do {
            homeFeed = []
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashModel].self, from: data)
            homeFeed = deserializedData
        } catch {
            print("Error: \(error)")
        }
    }
}

