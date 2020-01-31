//
//  YelpProvider.swift
//  FoodHub
//
//  Created by Gary Tokman on 1/26/20.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import Moya
import Foundation

enum YelpProvider: TargetType {
    #error("get an api key see README.md")
    static let apiKey = ""
    
    case businesses(term: String, lat: Double, long: Double)
    
    var baseURL: URL {
        return URL(string: "https://api.yelp.com/v3/businesses")!
    }
    
    var path: String {
        switch self {
        case .businesses:
            return "search"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        let path = Bundle.main.path(forResource: "API", ofType: "json")
        return try! Data(contentsOf: URL(string: path!)!)
    }
    
    var task: Task {
        switch self {
        case let .businesses(term, lat, long):
            return .requestParameters(parameters: [
                "term": term,
                "latitude": lat,
                "longitude": long,
            ], encoding: URLEncoding.init())
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(YelpProvider.apiKey)"]
    }
}
