//
//  PeopleLoader.swift
//  Yalies
//
//  Created by Tiger J. Wang on 4/11/21.
//

import Foundation
import Alamofire

class PeopleLoader: ObservableObject {
    @Published var people: [YCStudent] = []
    @Published var isLoading: Bool = false
    
    func loadPeople(keyword: String) {
        isLoading = true
        let apikey = ProcessInfo.processInfo.environment["apikey"]!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apikey)",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "query": keyword,
            "filters": [
                "school_code": "YC"
            ]
        ]
        AF.request("https://yalies.io/api/people", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            // debugPrint(response)
            do {
                self.people = try JSONDecoder().decode([YCStudent].self, from: response.data!)
                // print(self.people)
            } catch {
                print(error.localizedDescription)
            }
        
            self.isLoading = false
        }
    }
}
