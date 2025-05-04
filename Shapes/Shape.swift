//
//  Shape.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//
import Foundation

struct Shape: Identifiable, Equatable {
    
    let name: String
    let drawPath: DrawPath
    let id: String?
    
    enum DrawPath: String {
        case circle
        case square
        case triangle
        case unknown
    }
    
    func makeNewCopy() -> Shape {
        .init(name: name, drawPath: drawPath, id: UUID().uuidString)
    }
    
    init(name: String, drawPath: DrawPath = .unknown, id: String? = nil) {
        self.name = name
        self.drawPath = drawPath
        self.id = id
    }
}

extension Shape: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
        case id
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let drawPath = try container.decode(String.self, forKey: .drawPath)
        self.drawPath = DrawPath(rawValue: drawPath) ?? .unknown
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
    }

}

struct ShapeContainer: Decodable {
    let buttons: [Shape]
}
