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
    
    var body: some View {
//        ForEach(filterCountries.indices, id:\.self)
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

//VStack{
//    NavigationView {
//        List(apiManager.country.indices, id:\.self, rowContent:{(index) in
//            NavigationLink(
//                destination: CountryDetailView(country: apiManager.country[index]),
//                label: {
//                    CountryRow(country: apiManager.country[index]).frame(width:350)
//                })
//                .navigationTitle("Country")
//        })
//    }
//
//    Button(action: {
//        self.showSearch = true
//    }, label: {
//        Text("更換國家")
//    }).sheet(isPresented: $showSearch){
//        VStack{
//            SearchView(showSearch: $showSearch)
//        }
//    }
//}
