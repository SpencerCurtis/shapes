//
//  ShapeService.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import Foundation

protocol ShapeService {
    func fetchShapes() async throws -> [Shape]
}

final class RemoteShapeService: ShapeService {
    func fetchShapes() async throws -> [Shape] {
        let url = URL(string: "https://staticcontent.cricut.com/static/test/shapes_001.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ShapeContainer.self, from: data).buttons
    }
}

final class LocalShapeService: ShapeService {
    func fetchShapes() async throws -> [Shape] {
        guard let url = Bundle.main.url(forResource: "shapes_001", withExtension: "json") else {
            throw NSError(domain: "LocalShapeService", code: -999, userInfo: [NSLocalizedDescriptionKey: "Could not find shapes_001.json in bundle"])
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(ShapeContainer.self, from: data).buttons
    }
}
