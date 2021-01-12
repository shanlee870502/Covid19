//
//  Country.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/8.
//

import Foundation


struct Country: Codable{
    var updated: Int
    var country: String
    var countryInfo: countryInfo

    //Total covid info
    var cases: Int
    var deaths: Int
    var recovered: Int
    var active: Int
    var casesPerOneMillion:Int

    //Daily covid info
    var todayCases: Int
    var todayDeaths: Int
    var todayRecovered: Int
}

struct countryInfo: Codable {
    var iso3: String?
    var lat: Float
    var long: Float
    var flag: URL
}


//Country Statistic

struct Statistic: Decodable{
    var country: String
    var timeline: Timeline
}

struct Timeline: Decodable{
    var cases: StatisticResponse
    var deaths: StatisticResponse
    var recovered: StatisticResponse
}



struct StatisticResponse: Decodable{
    struct CodingKeys: CodingKey{
        var intValue:Int?
        init?(intValue:Int){
            return nil
        }
        var stringValue: String
        init?(stringValue: String){
        self.stringValue = stringValue
        }
    }

    var data:[Date:Double]
    var values:[Double]
    init(from decoder: Decoder) throws{
        values = [Double]()
        data = [Date:Double]()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        for _key in container.allKeys {
            let value = try container.decode(Double.self, forKey: _key)
            let date = dateFormatter.date(from:_key.stringValue)!
            data[date] = value
            values.append(Double(value))
        }
    }
    
}

// Country Photos
struct ImageResponse:Decodable {
    var hits:[CountryPhoto]
}

struct CountryPhoto:Decodable {
    var id:Int
    var webformatURL:URL
}
