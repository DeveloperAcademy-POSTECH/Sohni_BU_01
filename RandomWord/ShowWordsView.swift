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
        List(words, id:\.self) { randomWord in
            Text(randomWord)
        }
        .task{
            await loadData()
        }
     //       Text(numberOfWords)
        }
          //    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
