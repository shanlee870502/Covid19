//
//  CountrySearchView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/9.
//

import Foundation
import SwiftUI
import URLImage

struct SearchView: View {
    @Binding var showSearch: Bool
    @ObservedObject var apiManager = APIManager.shared
    @State private var searchText = ""
    @State private var selectCountry: String=""
    @State private var selectedIndex = 0
//    let searchType = ["國家名稱","感染人數","死亡人數"]
    let names=["abc", "def", "ark"]
    var filterCountries:[Country] {
        return apiManager.allCountry.filter({searchText.isEmpty ? true : $0.country.contains(searchText)})
    }
    var body: some View {
        List{
            SearchBar(text: $searchText)
//            Picker(selection: $selectedIndex, label: Text("選擇角色")) {
//                ForEach(searchType.indices) { (index) in
//                    Text(searchType[index])
//                }
//            }
            .pickerStyle(SegmentedPickerStyle())
            ForEach(filterCountries.indices, id:\.self) { (index) in
                HStack{
                Text(filterCountries[index].country)
                    Spacer()
                URLImage(url:filterCountries[index].countryInfo.flag,
                         content: {image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width:50)
                            
                         })
                }
                .contentShape(Rectangle())
                .listRowBackground(self.selectCountry == filterCountries[index].country ? Color.gray : Color(UIColor.systemGroupedBackground))
                .onTapGesture {
                    self.selectCountry = filterCountries[index].country
                    apiManager.updateSelectedCountry(country: filterCountries[index].country)
                    showSearch = false
                    
                }
            }
        }
    }
}

