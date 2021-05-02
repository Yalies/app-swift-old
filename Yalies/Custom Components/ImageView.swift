//
//  ImageView.swift
//  Yalies
//
//  Created by Tiger J. Wang on 4/11/21.
//
// ATTRIBUTION:
// https://www.lukecsmith.co.uk/2020/11/20/loading-from-url-and-caching-images-in-swiftui/

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageLoader: ImageLoaderAndCache

    init(_ url: String) {
        imageLoader = ImageLoaderAndCache(imageURL: url)
    }

    var body: some View {
          Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage())
            .resizable()
            .frame(width: 100, height: 120)
    }
}

class ImageLoaderAndCache: ObservableObject {
    
    @Published var imageData = Data()
    
    init(imageURL: String) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let data = cache.cachedResponse(for: request)?.data {
            // print("got image from cache")
            self.imageData = data
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                let cachedData = CachedURLResponse(response: response, data: data)
                                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        // print("downloaded from internet")
                        self.imageData = data
                    }
                }
            }).resume()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView("https://yalestudentphotos.s3.amazonaws.com/d529cd77684081de617222a0a54ecac4.jpg")
    }
}
