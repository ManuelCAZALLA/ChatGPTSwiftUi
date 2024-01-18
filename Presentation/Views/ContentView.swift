//
//  ContentView.swift
//  ChatSwiftUi
//
//  Created by Manuel Cazalla Colmenero on 17/1/24.
//

import SwiftUI

struct ContentView: View {
   @StateObject var viewModel = ViewModel()
    @State var prompt: String = "Dime la diferencia entre class y struct"
    
    var body: some View {
        VStack {
            ConversationView()
                .environmentObject(viewModel)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack{
                TextField("Escribe la pregunta al asistente", text: $prompt, axis: .vertical)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(25)
                    .lineLimit(6)
                
                Button {
                    Task {
                        await viewModel.send(message: prompt)
                    }
                } label: {
                    
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color.white)
                            .frame(width: 44, height: 44)
                            .background( Color.blue)
                            .cornerRadius(22)
                    }
                .padding(.leading, 8)
                }
                .padding()
            }
            
        }
        
    }


#Preview {
    ContentView()
}
