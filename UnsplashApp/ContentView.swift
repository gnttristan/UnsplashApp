//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Tristan GINET on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var feedState = FeedState()
    let rowTopics: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    func loadData() async {
        await feedState.loadFeedPhotos()
    }
    
    var body: some View {
        NavigationStack() {
            Section(){
                VStack {
                    HStack(spacing: 8) {
                        if feedState.topicFeed.isEmpty {
                            ForEach(0..<3, id: \.self) { _ in
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                            }
                        } else {
                            ForEach(feedState.topicFeed.prefix(3), id: \.id) { topic in
                                NavigationLink(destination: TopicDetailsView(topic: topic)) {
                                    VStack() {
                                        AsyncImage(url: URL(string: topic.coverPhoto.urls.small)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(height: 60)
                                        .cornerRadius(12)
                                        .shadow(radius: 5)
                                        
                                        Text(topic.title)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .onAppear {
                Task{
                    await feedState.loadFeedTopics()
                }
            }
            Section() {
                VStack {
                    Button(action: {
                        Task {
                            await loadData()
                        }
                    }, label: {
                        Text("Load Data")
                    })
                }
                GridPhotoComponent(images: feedState.homeFeed)
            }
            .navigationBarTitle("Feed", displayMode: .large)
        }
    }
}

#Preview {
    ContentView()
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .clipped()
        }
    }
}




