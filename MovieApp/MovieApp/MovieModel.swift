//
//  MovieModel.swift
//  MovieApp
//
//  Created by 이택성 on 2022/01/24.
//

import Foundation

struct MovieModel: Codable {                // Json파일을 인코딩 디코딩 하기 위해 Codable
    
    let resultCount: Int
    let results: [MovieResult]
}


struct MovieResult: Codable {
    
    // 백엔드에서 테이터를 안주는 경우도 있기 때문에 데이터 타입은 보통 옵셔널로 한다.
    let trackName: String?
    let previewUrl: String?
    let artworkUrl100: String?
    let shortDescription: String?
    let longDescription: String?
    let trackPrice: Double?
    let currency: String?
    let releaseDate: String?

    
    // 혹여나 데이터 받을 때에 다른 이름으로 사용하고 싶으면 이렇게 설정해도 됨, 단 하나하나 다 설정해야함.
//    enum CodingKeys: String, CodingKey {
//        case image = "artworkUrl100"
//        case trackName
//        case previewUrl
//    }

}
