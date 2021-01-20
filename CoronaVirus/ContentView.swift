//
//  ContentView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/9.
//

import SwiftUI
import PartialSheet

struct ContentView: View {
    var album = Album()
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.imgName, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        TabView{
            CountryView()
                .environmentObject(album)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Country Info")
                }
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Covid News")
                }
            AlbumView()
                .environmentObject(album)
                .tabItem{
                    Image(systemName: "photo.fill")
                    Text("My Collection")
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
