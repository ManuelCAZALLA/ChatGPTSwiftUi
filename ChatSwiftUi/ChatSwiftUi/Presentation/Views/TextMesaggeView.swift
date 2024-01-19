//
//  TextMesaggeView.swift
//  ChatSwiftUi
//
//  Created by Manuel Cazalla Colmenero on 17/1/24.
//

import SwiftUI
import SwiftOpenAI

import SwiftUI

struct TextMessageView: View {
    var message: MessageChatGPT
    
    var body: some View {
        HStack {
            if message.role == .user {
                Spacer()
                Text(message.text)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue))
                    .frame(maxWidth: 240, alignment: .trailing)
            }else {
                Text(message.text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray)
                    )
                    .frame(maxWidth: 240,alignment: .leading)
                Spacer()
            }
        }
    }
}

struct TextMessage_Previews: PreviewProvider {
    static let chatGPTMessage: MessageChatGPT = .init(text: "Hola, estoy aquí para ayudarte", role: .system)

    static let myMessage: MessageChatGPT = .init(text: "¿Cuándo se usó por primera vez el lenguaje Swift?", role: .user)
    
    static var previews: some View {
        Group {
            TextMessageView(message: TextMessage_Previews.chatGPTMessage)
                .previewDisplayName("chatGPT Message")
            TextMessageView(message: TextMessage_Previews.myMessage)
                .previewDisplayName("My Message")
        }
        .previewLayout(.sizeThatFits)
    }

   
}
