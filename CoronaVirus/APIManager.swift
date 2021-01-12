//
//  APIManager.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/8.
//

import Foundation
import SwiftUI
import Combine

class APIManager: ObservableObject {
    
    static let shared = APIManager()
    
    @Published var country = [Country]()
    @Published var selectedCountry:String
    @Published var allCountry = [Country]()
    @Published var news = [News.article]()
    @Published var cases = [(String,Double)]()
    @Published var deathes = [(String,Double)]()
    @Published var recovered = [(String,Double)]()
    @Published var countryPhotos = [CountryPhoto]()
    
    init() {
        selectedCountry = "Taiwan"
        getOneCountryCovidInfo()
        getAllCountryCovidInfo()
        getCovidNews()
        getCountryStatistic()
        getCountryImage()
    }

    func updateSelectedCountry(country:String)
    {
        self.selectedCountry = country
        getOneCountryCovidInfo()
        //initialized again
        self.cases = [(String,Double)]()
        self.deathes = [(String,Double)]()
        self.recovered = [(String,Double)]()
        getCountryStatistic()
        getCountryImage()
    }
    
    func getOneCountryCovidInfo(){
        guard let queryUrl = URL(string:"https://corona.lmao.ninja/v2/countries/\(self.selectedCountry)?yesterday=true&sort=") else{ return }
        var request = URLRequest(url: queryUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else { return }
            let response = try!JSONDecoder().decode(Country.self, from: data)
            DispatchQueue.main.async {
                self.country=[response]
            }
            print("country data fetched successfully")
        }.resume()
    }
    

    func getAllCountryCovidInfo(){
        guard let queryUrl = URL(string:"https://corona.lmao.ninja/v2/countries?yesterday&sort=cases") else { return }
        var request = URLRequest(url: queryUrl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else {return}
            let response = try!JSONDecoder().decode([Country].self, from: data)
            DispatchQueue.main.async {
                self.allCountry = response
            }
            print("all country data fetched successfullly")
        }.resume()
        
    }
    
    //News API Key: bc97ce7a97e54cc8822caf3456656f42
    func getCovidNews()
    {
        guard let queryUrl = URL(string:"https://newsapi.org/v2/everything?q=covid&from=2021-01-07&to=2021-01-10&sortBy=popularity&apiKey=bc97ce7a97e54cc8822caf3456656f42") else { return }
        var request = URLRequest(url: queryUrl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else {return}
            let response = try!JSONDecoder().decode(News.self, from: data)
            DispatchQueue.main.async {
                self.news = response.articles
            }
            print("news data fetched successfullly")
        }.resume()
        
    }
    
    func getCountryStatistic(){
        guard let queryUrl = URL(string: "https://corona.lmao.ninja/v2/historical/\(self.selectedCountry)?lastdays=300") else { return }
        var request = URLRequest(url: queryUrl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){data, response, errror in
            guard let data = data else {return}
            let response = try!JSONDecoder().decode(Statistic.self,from: data)
//            print(response.timeline.deaths.data.sorted(by: { $0.0 < $1.0 }))
//            print(response.timeline.recovered.data.sorted(by: {$0.0 < $1.0}))
//            print(response.timeline.recovered.values)
            DispatchQueue.main.async {
                let cases_dict = response.timeline.cases.data.sorted(by:{ $0.0 < $1.0 })
                let deathes_dict = response.timeline.deaths.data.sorted(by:{ $0.0 < $1.0 })
                let recovered_dict = response.timeline.recovered.data.sorted(by:{ $0.0 < $1.0 })
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .short
                for(key, value) in cases_dict{
                    self.cases.append((formatter1.string(from:key), value))
                }
                for(key, value) in deathes_dict{
                    self.deathes.append((formatter1.string(from:key), value))
                }
                for(key, value) in recovered_dict{
                    self.recovered.append((formatter1.string(from:key), value))
                }
            }
        }.resume()
        
    }
    
    // get specifc country image
    //api key:19853961-5610843a121e5db3f4a2df753
    func getCountryImage(){
        guard let queryUrl = URL(string:"https://pixabay.com/api/?key=19853961-5610843a121e5db3f4a2df753&q=\(self.selectedCountry)&image_type=photo") else{ return }
        var request = URLRequest(url: queryUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else { return }
            let response = try!JSONDecoder().decode(ImageResponse.self, from: data)
            print("\(response.hits.count)")
            DispatchQueue.main.async {
                self.countryPhotos = response.hits
            }
            
        }.resume()
        
    }
    
}


