//
//  ShapeViewModel.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import SwiftUI

class ShapeViewModel: ObservableObject {
    
    @Published var shapeButtons: [Shape] = []
    @Published var gridShapes: [Shape] = []
    
    private let shapeService: any ShapeService
    
    init(shapeService: ShapeService) {
        self.shapeService = shapeService
    }
    
    @MainActor
    func loadShapes() async throws {
        shapeButtons = try await shapeService.fetchShapes()
    }
    
    func addShapeToGrid(_ shape: Shape) {
        gridShapes.append(shape)
    }
    
    func clearAllGridShapes() {
        gridShapes.removeAll()
    }
    
    func gridImage(for drawPath: Shape.DrawPath) -> Image {
        switch drawPath {
        case.circle:
            return Image(systemName: "circle.fill")
        case .square:
            return Image(systemName: "square.fill")
        case .triangle:
            return Image(systemName: "triangle.fill")
        case .unknown:
            fatalError("Unsupported draw path")
        }
    }
    
}
