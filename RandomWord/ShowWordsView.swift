//
//  ShowWordsView.swift
//  RandomWord
//
//  Created by Heeji Sohn on 2022/05/28.
//

import SwiftUI



struct ShowWordsView: View {
    @Binding var numberOfWords:Int
    @State var words = [String]()
    
    var body: some View {
        
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
            
            List(words, id:\.self) { randomWord in
                Text(randomWord)
            }
            .task{
                await loadData()
            }
        }
    }
    
    func loadData() async{
        guard let url = URL(string:"https://random-word-api.herokuapp.com/word?number=\(numberOfWords+1)") else {
            print("Invalid")
            return
        }
        
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([String].self, from: data){
                words = decodedResponse
            }
        } catch{
            print("Invalid!!")
        }
    }
    
}

struct ShowWordsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChooseNumView()
    }
    
}
