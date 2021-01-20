//
//  AlbumView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/12.
//

import Foundation
import SwiftUI
import CoreData

struct AlbumView: View {
    @EnvironmentObject var album: Album
    var body : some View {
        VStack{
           List(album.name.indices, id:\.self){(index) in
                Image(uiImage: getSavedImage(named: album.name[index])!)
                    .resizable()
                    .scaledToFit()
           }
        }
    }
}

func getSavedImage(named: String) -> UIImage? {
    if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
        return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
    }
    return nil
}


