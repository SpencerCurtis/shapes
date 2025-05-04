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
    
    var circleGridShapes: [Shape] {
        gridShapes.filter({ $0.drawPath == .circle })
    }
    
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
    
    func deleteAllCircles() {
        gridShapes.removeAll(where: { $0.drawPath == .circle })
    }
    
    func appendCircle() {
        gridShapes.append(.init(drawPath: .circle))
    }
    
    func removeLastCircle() {
        guard let index = gridShapes.lastIndex(where: { $0.drawPath == .circle }) else {
            NSLog("No circle to remove")
            return
        }
        gridShapes.remove(at: index)
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
