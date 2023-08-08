//
//  Button.swift
//  TableExample
//
//  Created by Marius Preikschat on 08.08.23.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button("Hello, SwiftUI!") {
            print("hehe clicked")
        }
        .font(.subheadline)
        .buttonStyle(.bordered)
        .tint(.green)
        .foregroundStyle(.green)
        .padding()
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
