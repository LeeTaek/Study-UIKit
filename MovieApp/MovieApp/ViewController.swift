//
//  ViewController.swift
//  MovieApp
//
//  Created by 이택성 on 2022/01/24.
//

import UIKit

class ViewController: UIViewController {

    var movieModel: MovieModel?
    
    @IBOutlet weak var movieTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var term = ""
    
    var networkLayer = NetworkLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        
        requestMovieAPI()
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        networkLayer.request(type: .justURL(url: urlString)) { data, response, error in
            if let hasData = data {
               completion(UIImage(data: hasData))
               return
           }
            completion(nil)
        }
    }
    
//
//    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
//
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        if let hasURL = URL(string: urlString) {
//            var request = URLRequest(url: hasURL)
//            request.httpMethod = "GET"
//
//        //  클로저의 데이터값은 이 함수 안에서만 유효하다.
//        // 함수 밖에서도 데이터 값을 쓰기 위해서는 @escaping을 사용하면 된다.
//            session.dataTask(with: request) { data, response, error in
//                print( (response as! HTTPURLResponse).statusCode )       // 200 뜨는지 찍어봐야함
//
//                if let hasData = data {
//                    completion(UIImage(data: hasData))
//                    return
//                }
//            }.resume()      // 위의 동작을 실행한다는 것.
//            session.finishTasksAndInvalidate()  //   세션 없애는 과정
//        }
//
//        // 혹시 데이터가 없는 경우 위의 동작으로 메모리를 계속 잡고 있음.
//        // 안되는 경우 nil로 반환.
//        completion(nil)
//
//    }
    
//    func requestMovieAPI() {
//        let term = URLQueryItem(name: "term", value: term)
//        let media = URLQueryItem(name: "media", value: "movie")
//        let querys = [term, media]
//
//        networkLayer.request(type: .searchMovie(querys: querys)) { data, response, error in
//
//            if let hasData = data {
//
//                // decode는 try-catch문으로 작성해야 한다.
//                // do에서 에러가 나오면 catch문의 에러 사유를 출력한다.
//                do {
//                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
//
//                    print(self.movieModel ?? "no data")
//
//                    DispatchQueue.main.async {
//                        self.movieTableView.reloadData() // 테이블을 다시 읽어라.
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }
//
//    }
    

    //네트워크 호출, 거의 기본적인 개념이라 이 흐름은 꼭 알아둬야 한다, status code 꼭 찾아보기
    func requestMovieAPI() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        var components = URLComponents(string: "https://itunes.apple.com/search")

        // 위의 url에 "https://itunes.apple.com/search?term=marvel&media=movie"으로 써도 된다.
        // 그런데 길어져서 보통 잘 안쓰고 밑의 3줄과 같이 쓴다.
        let term = URLQueryItem(name: "term", value: term)
        let media = URLQueryItem(name: "media", value: "movie")
        components?.queryItems = [term, media]

        guard let url = components?.url else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { data, response, error in   //   data는 옵셔널

            print( (response as! HTTPURLResponse).statusCode )       // 200 뜨는지 찍어봐야함

            if let hasData = data {

                // decode는 try-catch문으로 작성해야 한다.
                // do에서 에러가 나오면 catch문의 에러 사유를 출력한다.
                do {
                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)

                    print(self.movieModel ?? "no data")

                    백시 읽어라.
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModel?.results.count ?? 0
        
    }
    
    // 셀의 높이를 강제로 설정.
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
    // 셀의 높이를 컨텐츠 크기에 따라 설정
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension   // 컨텐츠 크기에 따라 설정.

    }
    
    // 세부 뷰컨드롤러
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        
        // 버튼 누른게 유지되는거 없앤다.
        tableView.deselectRow(at: indexPath, animated: true)
        
        detailVC.movieResult = self.movieModel?.results[indexPath.row]
        
//        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
          
    }
    
    
    // 셀에 채울 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.titleLable.text = self.movieModel?.results[indexPath.row].trackName
        cell.descrirptionLable.text = self.movieModel?.results[indexPath.row].shortDescription

        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        let price = self.movieModel?.results[indexPath.row].trackPrice?.description ?? ""
        
        cell.priceLable.text = currency + price

        //  이미지를 셀에 연결.
        if let hasURL = self.movieModel?.results[indexPath.row].artworkUrl100 {
            self.loadImage(urlString: hasURL) { image in
                
                DispatchQueue.main.async {
                    cell.movieImage.image = image
                }
            }
        }
        
        
        // ISO8601 형태로 된 날짜를 내가 원하는 형태로 출력.
        if let dateString = self.movieModel?.results[indexPath.row].releaseDate{
            let formatter = ISO8601DateFormatter()
            if let isoDate = formatter.date(from: dateString){
                let myFomatter = DateFormatter()
                myFomatter.dateFormat = "yyyy년 MM월 dd일"
                let dateString = myFomatter.string(from: isoDate)
                
                cell.dateLable.text = dateString
            }
        }
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let hasText = searchBar.text else {
            return
        }
        term = hasText
        requestMovieAPI()
        self.view.endEditing(true)
        
    }
}
