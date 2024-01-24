//
//  TopicDetailsView.swift
//  UnsplashApp
//
//  Created by Tristan GINET on 1/24/24.
//

import Foundation
import SwiftUI

struct TopicDetailsView : View {
    @StateObject var feedState = FeedState()
    @State var topic: UnslpashTopic
    
    let columnsItems: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    func loadDataTopic() async {
        await feedState.loadFeedPhotosOfTopic(idTopic: topic.id)
    }
   
    var body: some View {
        Section() {
            VStack {
                Button(action: {
                    Task {
                        await loadDataTopic()
                    }
                }, label: {
                    Text("Load...")
                })
                GridPhotoComponent(images: feedState.topicPhotoFeed)
            }
        }
        .navigationBarTitle(topic.title, displayMode: .large)
    }
}
