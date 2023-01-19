//
//  apiCaller.swift
//  newsApp
//
//  Created by Cubastion on 19/01/23.
//

import Foundation

class apiCaller {
    static var shared = apiCaller()
    
    struct Constant {
        static let urlString = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-12-19&sortBy=publishedAt&apiKey=668855d50fb9478d89a3569256c02012")
    }
    
    init(){
        
    }
    
    func apiCallerThing(completion: @escaping(Result<[Article], Error>) -> Void){
        guard let url = Constant.urlString else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }else if let data = data {
                do {
                    var someArray = try JSONDecoder().decode(newsArticles.self, from: data)
                    completion(.success(someArray.articles))
//                    print(someArray.articles.count)
                }catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
