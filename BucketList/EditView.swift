//
//  EditView.swift
//  BucketList
//
//  Created by Subhrajyoti Chakraborty on 02/09/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placeMarker: MKPointAnnotation
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    func fetchNearbyPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placeMarker.coordinate.latitude)%7C\(placeMarker.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                
                if let items = try? decoder.decode(Result.self, from: data) {
                    self.pages = Array(items.query.pages.values).sorted()
                    self.loadingState = .loaded
                    return
                }
            }
            
            self.loadingState = .failed
        }.resume()
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placeMarker.wrappedTitle)
                    TextField("Description", text: $placeMarker.wrappedSubtitle)
                }
                
                Section(header: Text("Nearby…")) {
                    if loadingState == .loaded {
                        List(pages, id:\.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                    .italic()
                        }
                    } else if loadingState == .loading{
                        Text("Loading...")
                    } else {
                        Text("Please try again later.")
                    }
                }
            }
            .navigationBarTitle("Edit place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placeMarker: MKPointAnnotation.example)
    }
}
