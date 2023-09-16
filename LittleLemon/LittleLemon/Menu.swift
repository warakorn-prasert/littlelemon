//
//  Menu.swift
//  LittleLemon
//
//  Created by Warakorn Mukdaprasert on 16/9/2566 BE.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    private func buildPredicate() -> NSPredicate {
        return searchText == "" ?
        NSPredicate(value: true) :
        NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(
            key: "title",
            ascending: true,
            selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                let dataObject = try? decoder.decode(MenuList.self, from: data)
                if let dataObject = dataObject {
                    for menuItem in dataObject.menu {
                        Dish.createDishFrom(menuItem: menuItem, viewContext)
                    }
                    try? viewContext.save()
                }
                
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            TextField("Search menu", text: $searchText)
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            VStack {
                                HStack {
                                    Text(dish.title ?? "")
                                    Text(dish.price ?? "")
                                }
                                Text(dish.menuDescription ?? "")
                            }
                            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()// Displays the loaded image.
                                }
                            }
                                
                        }
                    }
                }
            }
        }
        .onAppear() {
            getMenuData()
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
