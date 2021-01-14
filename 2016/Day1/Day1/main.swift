//
//  main.swift
//  Day1
//
//  Created by Stefan Arentz on 13/01/2021.
//

import Foundation

let input = "R1, L4, L5, L5, R2, R2, L1, L1, R2, L3, R4, R3, R2, L4, L2, R5, L1, R5, L5, L2, L3, L1, R1, R4, R5, L3, R2, L4, L5, R1, R2, L3, R3, L3, L1, L2, R5, R4, R5, L5, R1, L190, L3, L3, R3, R4, R47, L3, R5, R79, R5, R3, R1, L4, L3, L2, R194, L2, R1, L2, L2, R4, L5, L5, R1, R1, L1, L3, L2, R5, L3, L3, R4, R1, R5, L4, R3, R1, L1, L2, R4, R1, L2, R4, R4, L5, R3, L5, L3, R1, R1, L3, L1, L1, L3, L4, L1, L2, R1, L5, L3, R2, L5, L3, R5, R3, L4, L2, R2, R4, R4, L4, R5, L1, L3, R3, R4, R4, L5, R4, R2, L3, R4, R2, R1, R2, L4, L2, R2, L5, L5, L3, R5, L5, L1, R4, L1, R1, L1, R4, L5, L3, R4, R1, L3, R4, R1, L3, L1, R1, R2, L4, L2, R1, L5, L4, L5"

enum Turn {
    case left
    case right
}

struct Instruction {
    let turn: Turn
    let distance: Int
    
    static func parse(_ s: String) -> Instruction {
        let index = s.index(s.startIndex, offsetBy: 1)
        switch s.prefix(1) {
            case "R":
                return Instruction(turn: .right, distance: Int(s[index...])!)
            case "L":
                return Instruction(turn: .left, distance: Int(s[index...])!)
            default:
                fatalError("Unexpected instruction \(s)")
        }
    }
}

enum Direction {
    case north
    case east
    case south
    case west
    
    func turn(_ turn: Turn) -> Direction {
        switch turn {
        case .left:
            switch self {
            case .north:
                return .west
            case .east:
                return .north
            case .south:
                return .east
            case .west:
                return .south
            }
        case .right:
            switch self {
            case .north:
                return .east
            case .east:
                return .south
            case .south:
                return .west
            case .west:
                return .north
            }
        }
    }
}

func parseInput(_ input: String) -> [Instruction] {
    return input.components(separatedBy: ", ").compactMap { (Instruction.parse($0)) }
}

struct Position {
    var x: Int
    var y: Int
    
    static let origin = Position(x: 0, y: 0)
    
    func manhattanDistance() -> Int {
        return abs(x) + abs(y)
    }
}

extension Position: Hashable {
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

var direction: Direction = .north
var position = Position.origin

for instruction in parseInput(input) {
    direction = direction.turn(instruction.turn)
    switch direction {
        case .north:
            position.y += instruction.distance
        case .east:
            position.x += instruction.distance
        case .south:
            position.y -= instruction.distance
        case .west:
            position.x -= instruction.distance
    }
}

print("Part 1: \(position.manhattanDistance())")

//

direction = .north
position = Position.origin

var visited = Set<Position>()

instructions: for instruction in parseInput(input) {
    direction = direction.turn(instruction.turn)
    switch direction {
        case .north:
            for _ in 0..<instruction.distance {
                position.y += 1
                if visited.contains(position) {
                    print("Part 2: \(position.manhattanDistance())")
                    break instructions
                }
                visited.insert(position)
            }
        case .east:
            for _ in 0..<instruction.distance {
                position.x += 1
                if visited.contains(position) {
                    print("Part 2: \(position.manhattanDistance())")
                    break instructions
                }
                visited.insert(position)
            }
        case .south:
            for _ in 0..<instruction.distance {
                position.y -= 1
                if visited.contains(position) {
                    print("Part 2: \(position.manhattanDistance())")
                    break instructions
                }
                visited.insert(position)
            }
        case .west:
            for _ in 0..<instruction.distance {
                position.x -= 1
                if visited.contains(position) {
                    print("Part 2: \(position.manhattanDistance())")
                    break instructions
                }
                visited.insert(position)
            }
    }
}
