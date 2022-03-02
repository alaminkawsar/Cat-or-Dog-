//
//  AnimalModel.swift
//  Cat or Dog?
//
//  Created by Khayrul on 3/1/22.
//


import Foundation

class AnimalModel : ObservableObject {
    
    @Published var animal = Animal()
    
    func getAnimal() {
        
        let stringUrl = Bool.random() ? catUrl : dogUrl
        
        // Create a URL object
        let url = URL(string: stringUrl)

        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }

        // Get the URL Session
        let session = URLSession.shared

        // Create the data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there are no errors and that there is data
            if error == nil && data != nil {
                
                // Attempt to parse the JSON
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                        
                        let item = json.isEmpty ? [:] : json[0]
                        
                        if let animal = Animal(json: item) {
                            
                            DispatchQueue.main.async {
                                while animal.results.isEmpty {}
                                self.animal = animal
                            }
                        }
                    }
                    
                } catch let failure {
                    print(failure)
                }
            }
        }

        // Start the data task
        dataTask.resume()
    }
    
}

