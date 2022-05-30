//
//  ContentView.swift
//  RandomWord
//
//  Created by Heeji Sohn on 2022/05/28.
//

import SwiftUI

struct ChooseNumView: View {
    @State private var numberOfWords=0
    var body: some View {
        NavigationView{
            VStack{
                Picker("How many words do you want?",selection: $numberOfWords ) {
                    ForEach(1..<16){
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
                
                NavigationLink {
                    ShowWordsView(numberOfWords: $numberOfWords)
                } label: {
                    Text("Generate \(numberOfWords+1) Words")
                        .padding(.all)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                
            }
        }
        .padding(.horizontal)
        .frame(height: nil)
        .navigationBarTitle("How many words?")
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseNumView()
    }
}
