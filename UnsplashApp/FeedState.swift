//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Tristan GINET on 1/23/24.
//

import Foundation
import SwiftUI
import Combine

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto] = []
    @Published var topicFeed: [UnslpashTopic] = []
    @Published var topicPhotoFeed: [UnsplashPhoto] = []
      
    class API {
        static let shared = API()
        
        private let baseURL = URL(string: feedUrl(path: "")!.absoluteString)!
        
        func getPhotos() -> AnyPublisher<[UnsplashPhoto], Error> {
            URLSession
                .shared
                .dataTaskPublisher(for: baseURL.appendingPathComponent("/photos"))
                .map(\.data)
                .decode(type: [UnsplashPhoto].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
        
        func getTopics() -> AnyPublisher<[UnslpashTopic], Error> {
            URLSession
                .shared
                .dataTaskPublisher(for: baseURL.appendingPathComponent("/topics"))
                .map(\.data)
                .decode(type: [UnslpashTopic].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
        
        func getPhotosOfTopic(idTopic: String) -> AnyPublisher<[UnsplashPhoto], Error> {
            URLSession
                .shared
                .dataTaskPublisher(for: baseURL.appendingPathComponent("/topics/\(idTopic)/photos"))
                .map(\.data)
                .decode(type: [UnsplashPhoto].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    }

    func loadFeedPhotos() {
        API
            .shared
            .getPhotos()
            .receive(on: DispatchQueue.main)
            .catch { _ in Just([]) }
            .assign(to: &$homeFeed)
    }
    
    func loadFeedTopics() {
        API
            .shared
            .getTopics()
            .receive(on: DispatchQueue.main)
            .catch { _ in Just([]) }
            .assign(to: &$topicFeed)
    }
    
    func loadFeedPhotosOfTopic(idTopic: String) {
        API
            .shared
            .getPhotosOfTopic(idTopic: idTopic)
            .receive(on: DispatchQueue.main)
            .catch { _ in Just([]) }
            .assign(to: &$topicPhotoFeed)
    }
}

