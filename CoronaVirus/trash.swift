////
////  ContentView.swift
////  CoronaVirus
////
////  Created by User01 on 2021/1/8.
////
//
//import SwiftUI
//import CoreData
//
//struct AlbumView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.imgName, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        Text("\(items.count)")
//        List {
//            ForEach(items) { item in
//                if (item.imgName) != nil
//                {
//                    Image(uiImage: getSavedImage(named:item.imgName!)!)
//                }
//                
////                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
////            .onDelete(perform: deleteItems)
//        }
////        .toolbar {
////            ToolbarItem(placement: .navigationBarTrailing){
////                HStack {
////                    EditButton()
////                    Button(action: addItem) {
////                        Label("Add Item", systemImage:"plus")
////                    }
////                }
////            }
////        }
//    }
//
////    private func addItem() {
////        withAnimation {
////            let newItem = Item(context: viewContext)
////            newItem.timestamp = Date()
////            do {
////                try viewContext.save()
////            } catch {
////                // Replace this implementation with code to handle the error appropriately.
////                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
////                let nsError = error as NSError
////                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
////            }
////        }
////    }
//
////    private func deleteItems(offsets: IndexSet) {
////        withAnimation {
////            offsets.map { items[$0] }.forEach(viewContext.delete)
////
////            do {
////                try viewContext.save()
////            } catch {
////                // Replace this implementation with code to handle the error appropriately.
////                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
////                let nsError = error as NSError
////                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
////            }
////        }
////    }
//}
//
//func getSavedImage(named: String) -> UIImage? {
//    if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
//        return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
//    }
//    return nil
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//
//
