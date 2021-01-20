//
//  CountryDetailView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/8.
//

import Foundation
import SwiftUI
import URLImage
import WaterfallGrid
import ToastUI

struct CountryImageWallView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var album: Album
    
    var photos: [CountryPhoto]
    @State private var brightness=[Double](repeating: 0.0, count: 200)
    @State private var showingAlert = false
    @State private var imgName:String = ""
    @State private var imgURL = URL(string:"")
    @State private var showingSuccessToast = false
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            WaterfallGrid(photos.indices, id: \.self) { index in
                URLImage(url:photos[index].webformatURL,
                         content: {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .brightness(self.brightness[index])
                                .onTapGesture{}
                                .gesture(
                                    LongPressGesture(minimumDuration:1.5)
                                        .onChanged(){ _ in
                                            self.brightness[index] = -0.5
                                            print("long pressed!")
                                        }
                                        .onEnded(){ _ in
                                            self.imgURL = photos[index].webformatURL
                                            self.imgName = String(photos[index].id)
//                                            String(photos[index].id)
                                            self.showingAlert = true
                                            self.brightness[index] = 0.0
                                        }
                                )
                                
                         })
            }
            .gridStyle(spacing: 8,animation: .easeInOut(duration: 2))
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("儲存相片"), message: Text("要儲存這張相片嗎"), primaryButton: .default(Text("儲存"), action: {
                    if let data = try? Data(contentsOf: self.imgURL!)
                    {
                        let selectedImage: UIImage = UIImage(data: data)!
                        let success = saveImage(image: selectedImage, imgName: self.imgName)
                        if(success)
                        {
                            album.name.append(imgName)
                            self.showingSuccessToast = true
                        }
                        let coreSuccess = saveToCoreData(imgName:self.imgName)
                        print("\(coreSuccess)")
                    }
                }), secondaryButton: .default(Text("取消"), action: {
                   print("Cancel")
                }))
            }
            .toast(isPresented: $showingSuccessToast, dismissAfter: 1.0){
                ToastView{
                    Text("儲存成功!")
                }
            }
        }
        
    }
    //imgName
    func saveToCoreData(imgName:String) -> Bool {
        let newItem = Item(context: viewContext)
        var result = true
        
        newItem.imgName = imgName
//        newItem.timestamp = Date()
        do{
            try viewContext.save()
        }catch{
            result = false
            let nsError = error as NSError
            print("rrrrrrrrrrrrrrrrrrrr")
            print(nsError)
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }
    
}


func saveImage(image: UIImage, imgName: String) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
        return false
    }
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        try data.write(to: directory.appendingPathComponent(imgName)!)
        
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
}



struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryImageWallView(photos: [CountryPhoto(id:1, webformatURL: URL(string:"https://pixabay.com/get/55e7d4404e5aac14f1dc846096293e76103cd7e3524c704f742f7fd6904cc05d_640.jpg")!)])
    }
}
