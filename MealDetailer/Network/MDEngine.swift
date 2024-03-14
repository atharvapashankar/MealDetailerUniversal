//
//  MDEngine.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/2/24.
//

import Foundation

class MDEngine {
    
    /*
     https://themealdb.com/api/json/v1/1/filter.php?c=Dessert for fetching the list of meals in the  Dessert category. • https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
     */
    
    private let https : String = "https://"
    private let url : String = "themealdb.com"
    private let path : String = "/api/json/v1/1/"
    private let apiToFetchMealList : String = "filter.php?c=Dessert"
    private let apiToFetchMealDetail : String = "lookup.php?i="
    
    
    func reqeustDataForMealList(completion: @escaping (Result<[Meal], Error>) -> ()) {
        let url = https + url + path + apiToFetchMealList
        guard let urlString = URL(string: url) else { return }
        fetch(for: urlString, completion: { result in
            switch result {
            case .success(let data) :
                guard let decodedData = MDResponseParser().decodeDataForMealList(for: data) else { return }
                completion(.success(decodedData.meals))
            case .failure(let error) :
                NSLog("HTTP Request Failed \(error)")
                completion(.failure(NSError(domain: "Meals not fetched", code: -1)))
            }
        })
    }
    
    func reqeustDataForMealDetail(for desertId : String, completion: @escaping (Result<MDDynamicMealDetailSanitized, Error>) -> ()) {
        
        let url = https + url + path + apiToFetchMealDetail + desertId
        guard let urlString = URL(string: url) else { return }
        
        fetch(for: urlString, completion: { result in
            switch result {
            case .success(let data) :
                guard let decodedData = MDResponseParser().decodeDataForMealDetail(for: data) else { return }
                guard let sanitizedData = MDResponseParser().sanitizeResponse(for: decodedData) else { return }
                completion(.success(sanitizedData))
            case .failure(let error) :
                NSLog("HTTP Request Failed \(error)")
                completion(.failure(NSError(domain: "Meals not fetched", code: -1)))
            }
        })
        return
    }
    
    func fetch(for url : URL, completion: @escaping (Result<Data, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                } else if let error = error {
                    NSLog("HTTP Request Failed \(error)")
                    completion(.failure(NSError(domain: "Meals not fetched", code: -1)))
                }
            }
        }.resume()
    }
}

