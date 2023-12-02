//
//  Scrambler.swift
//  Cube_Test
//
//  Created by Daniel Madjar on 11/26/23.
//

import Foundation
import SwiftUI

struct Piece: Hashable, Identifiable {
    let id = UUID()
    let color: String
    
    init(color: String) {
        self.color = color
    }
}

class CubeViewModel: ObservableObject {
    @Published var cube: [[[Piece]]] = []
    
    let colors = ["O","G","R","B","W","Y"]
    
    let orange = 0, green = 1, red = 2, blue = 3, white = 4, yellow = 5
    
    init() {
        createCube()
    }
    
    func createCube() {
        for clr in colors {
            var face = [[Piece]]()
            for _ in 0...2 {
                var pieces = [Piece]()
                for _ in 0...2 {
                    pieces.append(Piece(color: clr))
                }
                face.append(pieces)
            }
            cube.append(face)
        }
    }
    
    // Every rotation rotates a face, and then a singular layer of 4 other faces.
    func moveUpOrDown(layer: Int, isClockwise: Bool) {
        if isClockwise {
            let temp: [Piece] = cube[orange][layer]
            cube[orange][layer] = cube[green][layer]
            cube[green][layer] = cube[red][layer]
            cube[red][layer] = cube[blue][layer]
            cube[blue][layer] = temp
        } else {
            let temp: [Piece] = cube[orange][layer]
            cube[orange][layer] = cube[blue][layer]
            cube[blue][layer] = cube[red][layer]
            cube[red][layer] = cube[green][layer]
            cube[green][layer] = temp
        }
    }
    
    func moveFrontLayer(isClockwise: Bool) {
        if isClockwise {
            for row in 0..<3 {
                let temp = cube[white][2][row]
                cube[white][2][row] = cube[orange][2 - row][2]
                cube[orange][2 - row][2] = cube[yellow][0][2 - row]
                cube[yellow][0][2 - row] = cube[red][row][0]
                cube[red][row][0] = temp
            }
        } else {
            for row in 0..<3 {
                let temp = cube[white][2][row]
                cube[white][2][row] = cube[red][row][0]
                cube[red][row][0] = cube[yellow][0][2 - row]
                cube[yellow][0][2 - row] = cube[orange][2 - row][2]
                cube[orange][2 - row][2] = temp
            }
        }
    }
    
    func moveBackLayer(isClockwise: Bool) {
        if isClockwise {
            for row in 0..<3 {
                let temp = cube[white][0][row]
                cube[white][0][row] = cube[red][row][2]
                cube[red][row][2] = cube[yellow][2][2 - row]
                cube[yellow][2][2 - row] = cube[orange][2 - row][0]
                cube[orange][2 - row][0] = temp
            }
        } else {
            for row in 0..<3 {
                let temp = cube[white][0][row]
                cube[white][0][row] = cube[orange][2 - row][0]
                cube[orange][2 - row][0] = cube[yellow][2][2 - row]
                cube[yellow][2][2 - row] = cube[red][row][2]
                cube[red][row][2] = temp
            }
        }
    }
    
    func moveRightLayer(isClockwise: Bool) {
        if isClockwise {
            for row in 0..<3 {
                let temp = cube[white][row][2]
                cube[white][row][2] = cube[green][row][2]
                cube[green][row][2] = cube[yellow][row][2]
                cube[yellow][row][2] = cube[blue][2 - row][0]
                cube[blue][2 - row][0] = temp
            }
        } else {
            for row in 0..<3 {
                let temp = cube[white][row][2]
                cube[white][row][2] = cube[blue][2 - row][0]
                cube[blue][2 - row][0] = cube[yellow][row][2]
                cube[yellow][row][2] = cube[green][row][2]
                cube[green][row][2] = temp
            }
        }
    }
    
    func moveLeftLayer(isClockwise: Bool) {
        if isClockwise {
            for row in 0..<3 {
                let temp = cube[white][row][0]
                cube[white][row][0] = cube[blue][2 - row][2]
                cube[blue][2 - row][2] = cube[yellow][row][0]
                cube[yellow][row][0] = cube[green][row][0]
                cube[green][row][0] = temp
            }
        } else {
            for row in 0..<3 {
                let temp = cube[white][row][0]
                cube[white][row][0] = cube[green][row][0]
                cube[green][row][0] = cube[yellow][row][0]
                cube[yellow][row][0] = cube[blue][2 - row][2]
                cube[blue][2 - row][2] = temp
            }
        }
    }

    func moveUp(isClockwise: Bool) {
        rotateFace(faceRotated: white, isClockwise: isClockwise)
        
        moveUpOrDown(layer: 0, isClockwise: isClockwise)
    }
    
    func moveDown(isClockwise: Bool) {
        rotateFace(faceRotated: yellow, isClockwise: !isClockwise)
        
        moveUpOrDown(layer: 2, isClockwise: isClockwise)
    }
    
    func moveRight(isClockwise: Bool) {
        rotateFace(faceRotated: red, isClockwise: isClockwise)
        
        moveRightLayer(isClockwise: isClockwise)
    }
    
    func moveLeft(isClockwise: Bool) {
        rotateFace(faceRotated: orange, isClockwise: isClockwise)
        
        moveLeftLayer(isClockwise: isClockwise)
    }
    
    func moveFront(isClockwise: Bool) {
        rotateFace(faceRotated: green, isClockwise: isClockwise)
        
        moveFrontLayer(isClockwise: isClockwise)
    }
    
    func moveBack(isClockwise: Bool) {
        rotateFace(faceRotated: blue, isClockwise: isClockwise)
        
        moveBackLayer(isClockwise: isClockwise)
    }
    
    func rotateFace(faceRotated: Int, isClockwise: Bool) {
        let row = 0
        if !isClockwise { // Counter-Clockwise
            for col in 0..<2 { // When Col is 0 rotating corners, When Col is 1 rotating edges
                let tempColor = cube[faceRotated][row][col]
                cube[faceRotated][row][col] = cube[faceRotated][col][2]
                cube[faceRotated][col][2] = cube[faceRotated][2][2 - col]
                cube[faceRotated][2][2 - col] = cube[faceRotated][2 - col][row]
                cube[faceRotated][2 - col][row] = tempColor
            }
        } else { // Clockwise
            for col in 0..<2 {
                let tempColor = cube[faceRotated][row][col]
                cube[faceRotated][row][col] = cube[faceRotated][2 - col][row]
                cube[faceRotated][2 - col][row] = cube[faceRotated][2][2 - col]
                cube[faceRotated][2][2 - col] = cube[faceRotated][col][2]
                cube[faceRotated][col][2] = tempColor
            }
        }
    }

    func move(moveNotation: String) {
        switch moveNotation {
        case "U2":
            moveUp(isClockwise: true)
            moveUp(isClockwise: true)
        case "U":
            moveUp(isClockwise: true)
        case "U’": // Option + shift + ]
            moveUp(isClockwise: false)
        case "D2":
            moveDown(isClockwise: false)
            moveDown(isClockwise: false)
        case "D":
            moveDown(isClockwise: false)
        case "D’":
            moveDown(isClockwise: true)
        case "R2":
            moveRight(isClockwise: true)
            moveRight(isClockwise: true)
        case "R":
            moveRight(isClockwise: true)
        case "R’":
            moveRight(isClockwise: false)
        case "L2":
            moveLeft(isClockwise: true)
            moveLeft(isClockwise: true)
        case "L":
            moveLeft(isClockwise: true)
        case "L’":
            moveLeft(isClockwise: false)
        case "F2":
            moveFront(isClockwise: true)
            moveFront(isClockwise: true)
        case "F":
            moveFront(isClockwise: true)
        case "F’":
            moveFront(isClockwise: false)
        case "B2":
            moveBack(isClockwise: true)
            moveBack(isClockwise: true)
        case "B":
            moveBack(isClockwise: true)
        case "B’":
            moveBack(isClockwise: false)
        default:
            print("Move does not exist")
        }
    }
    
    func scrambleCube(scramble: String) {
        let notation = scramble.components(separatedBy: " ")
        for turn in notation {
            move(moveNotation: turn)
        }
    }
    
    func printCube() {
        for face in cube {
            for row in face {
                for piece in row {
                    print(piece.color)
                }
            }
            print("--------")
        }
    }
    
    func resetCube() {
        self.cube = []
        createCube()
    }
}
