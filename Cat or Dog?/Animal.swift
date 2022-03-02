//
//  Animal.swift
//  Cat or Dog?
//
//  Created by Khayrul on 3/1/22.
//

import Foundation

class Animal {
    
    // image url as string
    var imageUrl: String
    
    // Optional Image data as Sata
    var imageData: Data?
    
    init() {
        imageUrl = ""
        imageData = nil
    }
    
    init?(json: [String: Any]) {
        
        // check that JSON has a url
        guard let imageUrl = json["url"] as? String else {
            return nil
        }
        self.imageUrl = imageUrl
        self.imageData = nil
        
        // Download the image data
        //getImage()
    }
    
    func getImage() {
        
        // Create a URL object
        let url = URL(string: imageUrl)
        
        // Check that the URL isn't nil
        guard url != nil else {
            print("Couldn't get URL object")
            return
        }
        // Get a URL session
        let session = URLSession.shared
        
        //Create the data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there are no errors and that there was data
            if error == nil && data != nil {
                self.imageData = data
            }
        }
        
        // Start data task
        dataTask.resume()
    }
}
