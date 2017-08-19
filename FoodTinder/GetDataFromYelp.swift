import Foundation

struct YelpData : Codable{
    var businesses : [businesses]
}
struct region : Codable{
    let center: center
}
struct center : Codable{
    let latitude:Float
    let longitude:Float
}

struct businesses : Codable {
    var name:String
    var rating: Float
    var price: String
}





func requestURL(completionHandler: @escaping (YelpData?) -> Void) {
    let search = "https://api.yelp.com/v3/businesses/search?latitude=34.1870&longitude=-118.3813"
    let url = URL(string: search)!
    var request = URLRequest(url: url)
    request.addValue("Bearer zJ5EZr0SjMEw7Q87joFLti8KJF9GamdrJzYWuSG7C5hB_fxgM36jBwDfut0bXXYRf9Gikapdkh66PNxECfl6SMb35TAc9ybB3DxepQkGW3KqUxEgQyBf6tgUFB6WWXYx ", forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: request) { (data, response, err)  in
        if err != nil {
            return
        }
        do {
            let result = try JSONDecoder().decode(YelpData.self, from: data)
        }
//            let decoded = try JSONDecoder().decode(YelpData.self, from: data)
//                completionHandler(decoded)
       
        
    }
    task.resume()
}

func saveData() -> [businesses] {
    var yelpData = [businesses]()
    requestURL { data in
        yelpData = (data?.businesses)!
    }
    return yelpData
}
//dictionary with an key of string, with a value of an array of dictionaries with a key of string

