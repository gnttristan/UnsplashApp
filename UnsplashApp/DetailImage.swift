//
//  DetailImage.swift
//  UnsplashApp
//
//  Created by Tristan GINET on 1/24/24.
//

import Foundation
import SwiftUI

struct DetailImageView : View {
    var image: UnsplashPhoto
    var imageServer: ImageSaver = ImageSaver()
    @State private var selectedImageFormatPicker: Urls.CodingKeys = .small
    @State private var downloadAlert = false
    
    var selectedImageFormat: String {
        switch selectedImageFormatPicker {
        case .raw: return image.urls.raw
        case .full: return image.urls.full
        case .regular: return image.urls.regular
        case .small: return image.urls.small
        case .thumb: return image.urls.thumb
        case .smallS3: return image.urls.smallS3
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        Text("Une image de @\(image.user.name)")
                            .bold()
                        AsyncImage(url: URL(string: image.user.profileImage.small)) { image in
                            image
                                .resizable()
                                .frame(width: 30, height: 30)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 200)
                        }
                        .shadow(radius: 5)
                    }
                    NavigationLink(destination: DetailAuthor(user: image.user)) {
                        Text("Biographie de l'auteur")
                    }
                    Picker("Select a case", selection: $selectedImageFormatPicker) {
                        ForEach(Urls.CodingKeys.allCases, id: \.self) { myCase in
                            Text(myCase.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 150, trailing: 0))
                
                VStack {
                    AsyncImage(url: URL(string: selectedImageFormat)) { image in
                        image
                            .imageDetail()
                    } placeholder: {
                        ProgressView()
                            .frame(maxHeight: .infinity)
                    }
                    .frame(height: 200)
                    .shadow(radius: 5)
                }
                .padding()
                
                Spacer()
            }
            HStack() {
                Image(systemName: "square.and.arrow.down")
                Button(action: {
                    downloadImage(imageUrl: selectedImageFormat)
                }, label: {
                    Text("Télécharger l'image")
                })
            }.alert(isPresented: $downloadAlert) {
                Alert(
                    title: Text("Téléchargement terminé"),
                    message: Text("L'image a été téléchargée avec succès."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func downloadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                var downloadedImage = UIImage(data: data)
                imageServer.saveImage(image: downloadedImage!)
                downloadAlert = true
            }
        }.resume()
    }
}

class ImageSaver: NSObject {
    func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully.")
        }
    }
}

extension Image {
    func imageDetail() -> some View {
        GeometryReader { geo in
            self
                .resizable()
        }
    }
}


    
//#Preview {
//    DetailImageView()
//}
