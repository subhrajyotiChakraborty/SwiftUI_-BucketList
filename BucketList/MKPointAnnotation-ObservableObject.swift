//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Subhrajyoti Chakraborty on 02/09/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import MapKit


extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown Value"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown Value"
        }
        set {
            subtitle = newValue
        }
    }
}
