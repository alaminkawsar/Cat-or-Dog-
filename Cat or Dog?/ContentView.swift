//
//  ContentView.swift
//  Cat or Dog?
//
//  Created by Khayrul on 3/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: AnimalModel
    
    var body: some View {
        
        VStack{
            
            AsyncImage(url: URL(string: model.animal.imageUrl)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .clipped()
            .edgesIgnoringSafeArea(.all)
            
            /*
            Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                .resizable()
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.all)
             */
             
            
            HStack {
                Text("What is it?")
                    .font(.title)
                    .bold()
                    .padding(.leading, 10)
                Button{
                    self.model.getAnimal()
                    //print(model.animal.imageData)
                } label: {
                    Text("Next")
                        .bold()
                }
            }
        }
        .onAppear(perform: model.getAnimal)
        //.opacity(model.animal.imageData == nil ? 0 : 1)
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: AnimalModel())
    }
}
