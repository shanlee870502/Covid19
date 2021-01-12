//
//  NewsRow.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/9.
//

import Foundation
import SwiftUI
import URLImage

struct ImageOverlay: View{
    var article: News.article
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.system(size: 20, weight: .regular, design: .serif))
                .bold()
                .padding(6)
                .foregroundColor(.white)
            Text(article.source.name)
                .font(.footnote)
                .foregroundColor(.white)
        }
        .cornerRadius(10.0)
        .padding(6)
    }
}
struct NewsRow: View{
    var article: News.article
    var body: some View{
        HStack {
            URLImage(url:article.urlToImage,
                     content: {image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .opacity(0.8)
                            .brightness(-0.1)
                        
                     }).overlay(ImageOverlay(article: article), alignment:.bottomLeading)
        }
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(article: News.article(source: Source(name: "123"), author: "123", title: "Hello world", description: "description", url: URL(string:"https://www.engadget.com/apple-car-hyundai-021027258.html")!, urlToImage: URL(string:"https://o.aolcdn.com/images/dims?resize=1200%2C630&crop=1200%2C630%2C0%2C0&quality=95&image_uri=https%3A%2F%2Fs.yimg.com%2Fos%2Fcreatr-images%2F2019-05%2F435339e0-734b-11e9-adff-495fd4484d17&client=amp-blogside-v2&signature=1e4bc139977a8a0997ef996d21440ca6c87fac6b")!, publishedAt: "2020/12/03"))
    }
}

