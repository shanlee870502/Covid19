//
//  CountryRow.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/8.
//

import SwiftUI
import URLImage

struct CountryRow: View {
    var country: Country
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                URLImage(url:country.countryInfo.flag,
                         content: {image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width:50)
                            
                         })
                Text("\(country.country)")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }.padding(.leading, 20)
            VStack(alignment: .leading){
                
                Group{
                    Text("本日資訊")
                        .foregroundColor(Color.CountryBgColor).bold()
                    Text("新增:   ").foregroundColor(.black)
                    + Text("\(country.todayCases)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("康復:   ").foregroundColor(.black)
                    + Text("\(country.todayRecovered)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("死亡:   ").foregroundColor(.black)
                    + Text("\(country.todayDeaths)")
                        .font(.headline)
                        .foregroundColor(.primary)
                }.padding(.leading, 20)
            }
            .frame(width: 300, height:100, alignment: .leading)
            .background(Color.CountryCardColor)
            .cornerRadius(15)
            .padding(.bottom,2)
            
            
            VStack(alignment: .leading){
                Group{
                    Text("統計資訊")
                        .foregroundColor(Color.CountryBgColor).bold()
                    Text("仍染疫人數:   \(country.active)").foregroundColor(.black)
                    Text("累計確診:     \(country.cases)").foregroundColor(.black)
                    Text("累計死亡:     \(country.deaths)").foregroundColor(.black)
                    Text("感染比例:     \(country.casesPerOneMillion)").foregroundColor(.black) +
                    Text("(每百萬人)")
                        .foregroundColor(.secondary)
                        .font(.system(size:12))
                }.padding(.leading, 20)
            }
            .frame(width: 300, height:120, alignment: .leading)
            .background(Color.CountryCardColor)
            .cornerRadius(15)
        }
        .frame(width: 350, height:300)
        .background(Color.CountryRowColor)
        .cornerRadius(15)
    }
}
struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(country: Country(updated: 0, country: "Taiwan",countryInfo: countryInfo(iso3: "123", lat: 123.123, long: 123.123, flag: URL(string:"https://disease.sh/assets/img/flags/tw.png")!), cases: 123, deaths: 123, recovered: 123, active: 123,casesPerOneMillion: 123, todayCases: 123, todayDeaths: 123, todayRecovered: 123))
    }
}
