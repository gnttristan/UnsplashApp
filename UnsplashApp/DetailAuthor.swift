//
//  DetailAuthor.swift
//  UnsplashApp
//
//  Created by Tristan GINET on 1/24/24.
//

import Foundation
import SwiftUI

struct DetailAuthor: View {
    var user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                AsyncImage(url: URL(string: user.profileImage.large)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.red.opacity(0.4), lineWidth: 3))
                        .frame(width: 150, height: 150)
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 150)
                        .overlay(ProgressView())
                }
                .padding(.top, 25)
                .padding(.bottom, 10)

                if let location = user.location, !location.isEmpty {
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.green)
                        Text(location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                }

                if let bio = user.bio, !bio.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Biography")
                            .font(.headline)
                            .fontWeight(.medium)

                        Text(bio)
                            .font(.body)
                            .lineSpacing(5)
                            .foregroundColor(.secondary) // Adjusted text color
                    }
                    .padding(.horizontal) // Adjusted horizontal padding
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Biography", displayMode: .inline)
    }
}

