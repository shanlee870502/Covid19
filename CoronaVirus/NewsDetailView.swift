//
//  NewsDetailView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/9.
//

import Foundation
import SwiftUI
import URLImage


struct NewsDetailView: View{
    var article: News.article
    
    var body: some View{
        VStack{
            Text(article.title)
            Text(article.publishedAt)
            URLImage(url:article.urlToImage,
                     content: {image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                        
                     })
            Text(article.description)
            if article.author != nil {
                Text(article.author!)
            }
        }
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(article: News.article(source: Source(name: "123"), author: "123", title: "Hello world", description: "description", url: URL(string:"https://www.engadget.com/apple-car-hyundai-021027258.html")!, urlToImage: URL(string:"https://o.aolcdn.com/images/dims?resize=1200%2C630&crop=1200%2C630%2C0%2C0&quality=95&image_uri=https%3A%2F%2Fs.yimg.com%2Fos%2Fcreatr-images%2F2019-05%2F435339e0-734b-11e9-adff-495fd4484d17&client=amp-blogside-v2&signature=1e4bc139977a8a0997ef996d21440ca6c87fac6b")!, publishedAt: "2020/12/03"))
    }
}
