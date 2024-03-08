//
//  MDEngine.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/2/24.
//

import Foundation

class MDEngine {
    
    public enum menuDataType{
        case desertMenu
        case desertDetails
    }
    
    public enum ErrorType : Error {
        case dataFailure(Data)
    }
    
    /*
     https://themealdb.com/api/json/v1/1/filter.php?c=Dessert for fetching the list of meals in the  Dessert category. • https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
     */
    
    let https : String = "https://"
    let url : String = "themealdb.com"
    let path : String = "/api/json/v1/1/"
    let apiToFetchMealList : String = "filter.php?c=Dessert"
    let apiToFetchMealDetail : String = "lookup.php?i="
    
    
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
        //startRequestForMealList(forURL: urlString, completion: completion)
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
        //startRequestForMealDetail(forURL: urlString, completion: completion)
        return
    }
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

//func startRequestForMealList(forURL url : URL, completion: @escaping (Result<[Meal], Error>) -> ()) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        DispatchQueue.main.async {
//            
//            if let data = data {
//
//                guard let decodedData = MDResponseParser().decodeDataForMealList(for: data) else { return }
//                
//                let meal = decodedData.meals
//                completion(.success(decodedData.meals))
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//                completion(.failure(NSError(domain: "Meals not fetched", code: -1)))
//            }
//        }
//    }.resume()
//}
//func startRequestForMealDetail(forURL url : URL, completion: @escaping (Result<MDDynamicMealDetailSanitized, Error>) -> ()) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        DispatchQueue.main.async {
//            
//            if let data = data {
//                guard let decodedData = MDResponseParser().decodeDataForMealDetail(for: data) else { return }
//                guard let sanitizedData = MDResponseParser().sanitizeResponse(for: decodedData) else { return }
//                completion(.success(sanitizedData))
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//                completion(.failure(NSError(domain: "Meals not fetched", code: -1)))
//            }
//        }
//    }.resume()
//}



