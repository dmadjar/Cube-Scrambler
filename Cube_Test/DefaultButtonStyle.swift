//
//  AuthenticationButtonStyle.swift
//  gatherIOS
//
//  Created by Daniel Madjar on 11/10/23.
//

import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .fill(color)
                .frame(height: 55)
                .cornerRadius(10)
            
            configuration.label
                .foregroundColor(.white)
                .font(Font.custom("Inter-Bold", size: 20))
        }
    }
}
