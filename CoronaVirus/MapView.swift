//
//  MapView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/20.
//

import Foundation
//import SwiftUI
//
//struct MapView: View{
//    var lat: Float
//    var long: Float
//    var body: some View{
//        Text("\(lat)")
//        Text("\(long)")
//    }
//}

import SwiftUI
import MapKit

struct MapView: View {
    var lat: Float
    var long: Float
    var country:String
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )
    init(country:String,lat: Float, long: Float){
        self.lat = lat
        self.long = long
        self.country = country
    }
    var body: some View {
        Text(country).font(.system(.largeTitle, design: .rounded))
        VStack {
            Map(coordinateRegion: $region)
            Button(action: {
                self.region.center = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(long))
            }, label: {
                Text("在哪裏！")
            })
            Button("zoom") {
                withAnimation {
                    region.span = MKCoordinateSpan(
                        latitudeDelta: 100,
                        longitudeDelta: 100
                    )
                }
            }
        }
    }
}
