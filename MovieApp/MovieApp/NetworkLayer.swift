//
//  NetworkLayer.swift
//  MovieApp
//
//  Created by 이택성 on 2022/01/25.
//

import Foundation

enum MovieAPIType {
    case justURL(url:String)
    case searchMovie(querys: [URLQueryItem])
}

enum MovieAPIError: Error{
  case badURL
    
}


class NetworkLayer{
    // only url
    // url + parameter
    
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    
    
    func request(type: MovieAPIType, completion: @escaping NetworkCompletion) {     // 클로저를 파라미터로 받을 때에 기본적으로 _를 넣음
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let request = try buildRequest(type: type)
      
            //  클로저의 데이터값은 이 함수 안에서만 유효하다.
            // 함수 밖에서도 데이터 값을 쓰기 위해서는 @escaping을 사용하면 된다.
            session.dataTask(with: request) { data, response, error in
                print( (response as! HTTPURLResponse).statusCode )       // 200 뜨는지 찍어봐야함
                completion(data, response, error)
                
            }.resume()      // 위의 동작을 실행한다는 것.
            session.finishTasksAndInvalidate()  //   세션 없애는 과정
        
        } catch{
            print(error)
        }
    }
    
    

private func buildRequest(type: MovieAPIType) throws -> URLRequest {
        
        switch type {
        case .justURL(url: let urlString):
            guard let hasURL = URL(string: urlString) else {
                throw MovieAPIError.badURL
            }
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
        
        case .searchMovie(querys: let querys):
            
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = querys
            
            guard let url = components?.url else {
                throw MovieAPIError.badURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
            
            }
    }
}


