import Foundation


typealias Triangle = (a: Int, b: Int, c: Int)

func isValidTriangle(_ t: Triangle) -> Bool {
    t.a + t.b > t.c && t.b + t.c > t.a && t.a + t.c > t.b
}


func parseLine(_ s: String) -> Triangle {
    let values = s.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespaces)
            .filter { $0 != "" }
            .compactMap { Int($0) }
    return (values[0], values[1], values[2])
}

func loadInput() -> [Triangle] {
    let contents = try! String(contentsOfFile: "/Users/stefan/Desktop/Day3/Day3/input")
    return contents.components(separatedBy: "\n")
        .filter { $0 != "" }
        .map { parseLine($0) }
}

let triangles = loadInput()

let count = triangles.filter { isValidTriangle($0) }.count
print("Part 1 Answer: \(count)")


// New approach - just read them all in and then interleave

func parseLine2(_ s: String) -> [Int] {
    return s.trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: .whitespaces)
        .filter { $0 != "" }
        .compactMap { Int($0) }
}

func loadInput2() -> [Triangle] {
    let contents = try! String(contentsOfFile: "/Users/stefan/Desktop/Day3/Day3/input")
    let values = contents.components(separatedBy: "\n")
        .filter { $0 != "" }
        .map { parseLine2($0) }
        .flatMap { $0 }
        
    var triangles = [Triangle]()
    
    for i in 0..<(values.count/9) {
        triangles.append((values[i*9+0], values[i*9+3], values[i*9+6]))
        triangles.append((values[i*9+1], values[i*9+4], values[i*9+7]))
        triangles.append((values[i*9+2], values[i*9+5], values[i*9+8]))
    }
    
    return triangles
}

let triangles2 = loadInput2()
let count2 = triangles2.filter { isValidTriangle($0) }.count
print("Part 2 Answer: \(count2)")
