//
//  QueryService.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/22/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import Foundation

// Runs query data task, and stores results in array of Tracks
class QueryService {
    
    typealias JSONDictionary = [String: Any] // To store the serialized data. typealias make the readability better.
    typealias QueryResult = ([Track]?, String) -> () // typealias make the readability better.
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var tracks: [Track] = [] // Local variable of model collection
    var errorMessage = ""
    
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        dataTask?.cancel() // Cancel current datatask if it exist
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "media=music&entity=song&term=\(searchTerm)" // URLComponents is helpful to create urls with query strings
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil } // Set the datatask to nil, once response is received.
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.parseSearchResults(data)
                    DispatchQueue.main.async {
                        completion(self.tracks, self.errorMessage)
                    }
                }
            }
            dataTask?.resume()
        }
    }
    
    fileprivate func parseSearchResults(_ data: Data) {
        var response: JSONDictionary?
        tracks.removeAll() // Remove the current collection, if exists.
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        var index = 0
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let previewURLString = trackDictionary["previewUrl"] as? String,
                let previewURL = URL(string: previewURLString),
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String {
                tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
    
}
