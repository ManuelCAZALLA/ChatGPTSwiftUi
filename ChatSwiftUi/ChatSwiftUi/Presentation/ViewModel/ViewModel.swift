//
//  ViewModel.swift
//  ChatSwiftUi
//
//  Created by Manuel Cazalla Colmenero on 17/1/24.
//

import Foundation
import SwiftOpenAI
import KeychainSwift

final class ViewModel: ObservableObject {
    private let keychain = KeychainManager()
    private let openAI: SwiftOpenAI

    @Published var messages: [MessageChatGPT] = [
        .init(text: "Hola soy tu asistente virtual y estoy aquí para ayudarte", role: .system)
    ]

    @Published var currentMessage: MessageChatGPT = .init(text: "", role: .assistant)

    init(apiKey: String) {
        self.openAI = SwiftOpenAI(apiKey: apiKey)
    }

    func send(message: String) async {
        guard let apiKey = loadToken() else {
            print("No se pudo obtener el token.")
            return
        }
       
        keychain.save(token: apiKey)

        let optionalParameters = ChatCompletionsOptionalParameters(temperature: 0.7, stream: true, maxTokens: 200)

        await MainActor.run {
            let myMessage = MessageChatGPT(text: message, role: .user)
            self.messages.append(myMessage)

            self.currentMessage = MessageChatGPT(text: "", role: .assistant)
            self.messages.append(self.currentMessage)
        }

        do {
            let stream = try await openAI.createChatCompletionsStream(model: .gpt3_5(.gpt_3_5_turbo_1106),
                                                                      messages: messages,
                                                                      optionalParameters: optionalParameters)
            for try await response in stream {
                print(response)
                await onReceive(newMessage: response)
            }
        } catch {
            print("Error: \(error)")
        }
    }

    @MainActor
    private func onReceive(newMessage: ChatCompletionsStreamDataModel) {
        let lastMessage = newMessage.choices[0]
        guard lastMessage.finishReason == nil else {
            print("Finished streaming messages")
            return
        }
        guard let content = lastMessage.delta?.content else {
            print("Message with no content")
            return
        }
        currentMessage.text = currentMessage.text + content
        messages[messages.count - 1].text = currentMessage.text
    }
}

// MARK: - Extension

extension ViewModel {
    private func loadToken() -> String? {
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let token = dict["apiToken"] as? String {
               return token
        } else {
               print("No se pudo cargar el token desde el archivo .plist")
               return nil
        }
    }
}

