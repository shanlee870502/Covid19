//
//  NewsView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/9.
//

import Foundation
import SwiftUI


struct NewsView: View {
    @ObservedObject var apiManager = APIManager.shared
    var body: some View {
        VStack{
            NavigationView {
                List(apiManager.news.indices, id:\.self, rowContent:{(index) in
                    NavigationLink(
                        destination: NewsDetailView(article: apiManager.news[index]),
                        label: {
                            NewsRow(article: apiManager.news[index])
                        })
                })

            }
        }
    }
    
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

