//
//  ContentView.swift
//  Cube_Test
//
//  Created by Daniel Madjar on 11/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cvm = CubeViewModel()
    @State var scramble = ""
    
    var body: some View {
        ZStack {
            Color("blackColor").ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    TextField("", text: $scramble, prompt: Text("Type Scramble").foregroundColor(.gray))
                        .frame(height: 50)
                        .padding(.leading, 15)
                        .background(Color("blackColor"))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                .padding([.leading, .trailing], 30)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(spacing: 0) {
                        ForEach(cvm.cube[4], id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(row, id: \.self) { piece in
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(convertColor(color: piece.color))
                                        .frame(width: 30, height: 30)
                                        .border(Color("blackColor"), width: 3)
                                }
                            }
                        }
                    }
                    .offset(x: 90)

                    HStack(spacing: 0) {
                        ForEach(0..<4) { i in
                            VStack(spacing: 0) {
                                ForEach(cvm.cube[i], id: \.self) { row in
                                    HStack(spacing: 0) {
                                        ForEach(row, id: \.self) { piece in
                                            RoundedRectangle(cornerRadius: 5)
                                                .fill(convertColor(color: piece.color))
                                                .frame(width: 30, height: 30)
                                                .border(Color("blackColor"), width: 3)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    VStack(spacing: 0) {
                        ForEach(cvm.cube[5], id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(row, id: \.self) { piece in
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(convertColor(color: piece.color))
                                        .frame(width: 30, height: 30)
                                        .border(Color("blackColor"), width: 3)
                                }
                            }
                        }
                    }
                    .offset(x: 90)
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button("Scramble") {
                        cvm.scrambleCube(scramble: scramble)
                    }
                    .buttonStyle(DefaultButtonStyle(color: Color("greenColor")))
                    .padding([.leading, .trailing], 45)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
                
                    Button("Reset") {
                        cvm.resetCube()
                    }
                    .buttonStyle(DefaultButtonStyle(color: Color("orangeColor")))
                    .padding([.leading, .trailing], 45)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
                }
            }
        }
    }
    
    func convertColor(color: String) -> Color {
        switch color {
        case "R":
            return Color.red
        case "Y":
            return Color("yellowColor")
        case "G":
            return Color("greenColor")
        case "O":
            return Color.orange
        case "B":
            return Color("blueColor")
        case "W":
            return Color("backgroundColor")
        default:
            return Color.clear
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
