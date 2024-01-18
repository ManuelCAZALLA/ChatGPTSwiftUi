//
//  ConversationView.swift
//  ChatSwiftUi
//
//  Created by Manuel Cazalla Colmenero on 17/1/24.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            ForEach(viewModel.messages) { message in
                TextMessageView(message: message)
            }
        }
    }
}

#Preview {
    ConversationView().environmentObject(ViewModel())
}
