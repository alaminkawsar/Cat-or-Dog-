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
            
            /*
            AsyncImage(url: URL(string: model.animal.imageUrl)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .clipped()
            .edgesIgnoringSafeArea(.all)
            
            */
            GeometryReader { geometry in
                Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
            }
             
            HStack {
                Text("What is it?")
                    .font(.title)
                    .bold()
                    .padding(.leading, 10)
                Spacer()
                Button{
                    self.model.getAnimal()
                    //print(model.animal.imageData)
                } label: {
                    Text("Next")
                        .bold()
                }
                .padding()
            }
            List(model.animal.results){ result in
                HStack {
                    Text(result.imageLabel)
                        .bold()
                    Spacer()
                    Text(String(format: "%.2f%%", result.confidence*100))
                }
            }
            
        }
        .onAppear(perform: model.getAnimal)
        .opacity(model.animal.imageData == nil ? 0 : 1)
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: AnimalModel())
    }
}
