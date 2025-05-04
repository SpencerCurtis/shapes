//
//  ShapeViewModel.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import Foundation

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
    
}
