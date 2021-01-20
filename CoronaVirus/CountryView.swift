//
//  SwiftUIView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/8.
//

import SwiftUI
import PartialSheet

struct CountryView: View {
    @EnvironmentObject var album: Album
    @ObservedObject var apiManager = APIManager.shared
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @State private var showSearch:Bool = false
    @State private var showMap: Bool = false

    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(apiManager.country.indices, id:\.self){(index) in
                        NavigationLink(
                            destination: CountryImageWallView(photos: apiManager.countryPhotos).environmentObject(album),
                            label: {
                                CountryRow(country: apiManager.country[index])
                            })
                            .navigationTitle("Country")
                    }
                    HStack{
                        Button(action: {
                            apiManager.updateSelectedCountry(country: apiManager.country[0].country)
                        }, label: {
                            Text("刷新").foregroundColor(Color.white)
                        })
                        .padding()
                        .background(Color.CountryRowColor)
                        .cornerRadius(15)
                        Button(action: {
                            self.showSearch = true
                        }, label: {
                            Text("更換國家").foregroundColor(Color.white)
                        }).sheet(isPresented: $showSearch){
                            VStack{
                                SearchView(showSearch: $showSearch)
                            }
                        }.padding()
                        .background(Color.CountryBgColor)
                        .cornerRadius(15)
                        
                        Button(action: {
                            self.showMap = true
                        }, label: {
                            Text("查看地圖").foregroundColor(Color.white)
                        }).sheet(isPresented: $showMap){
                            VStack{
                                MapView(country: apiManager.country[0].country,lat: apiManager.country[0].countryInfo.lat, long: apiManager.country[0].countryInfo.long)
                            }
                        }.padding()
                        .background(Color.CountryBgColor)
                        .cornerRadius(15)
                    }
                    
                    StatisticView(cases:apiManager.cases, deathes: apiManager.deathes, recovered: apiManager.recovered)
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
            .environmentObject(PartialSheetManager())
    }
}


