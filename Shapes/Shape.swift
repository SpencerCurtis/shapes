//
//  Shape.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

struct Shape: Codable {
    let name: String
    let drawPath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}

struct ShapeContainer: Decodable {
    let buttons: [Shape]
}
