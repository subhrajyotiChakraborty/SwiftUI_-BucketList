//
//  ContentView.swift
//  BucketList
//
//  Created by Subhrajyoti Chakraborty on 30/08/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    
    let values = [1, 3, 5, 2, 9].sorted()
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
        ].sorted()
    var loadingState = LoadingState.success
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    struct LoadingView: View {
        var body: some View {
            Text("Loading...")
        }
    }
    
    struct SuccessView: View {
        var body: some View {
            Text("Success!")
        }
    }
    
    struct FailedView: View {
        var body: some View {
            Text("Failed.")
        }
    }
    
    var body: some View {
        //        List(values, id: \.self) {
        //            Text("\($0)")
        //        }
        
        //        List(users) { user in
        //            Text("\(user.lastName), \(user.firstName)")
        //        }
        
        Text("Hello world")
            .onTapGesture {
                FileManager.writeString("sasass.txt", message: "This is a test message")
        }
        
        //        Group {
        //            if loadingState == .loading {
        //                LoadingView()
        //            } else if loadingState == .success {
        //                SuccessView()
        //            } else if loadingState == .failed {
        //                FailedView()
        //            }
        //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct User: Identifiable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    let id = UUID()
    let firstName: String
    let lastName: String
}

extension FileManager {
    static func writeString(_ fileName: String, message: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(fileName)
        let str = message
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let text = try String(contentsOf: url)
            print(text)
        } catch {
            print(error.localizedDescription)
        }
    }
}
