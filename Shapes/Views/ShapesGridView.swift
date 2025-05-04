//
//  ShapesGridView.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import SwiftUI

struct ShapesGridView: View {
    
    @ObservedObject private var viewModel: ShapeViewModel
    
    var shapes: [Shape] = []
    
    init(viewModel: ShapeViewModel, shapes: [Shape]) {
        self.viewModel = viewModel
        self.shapes = shapes
    }
    
    private let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 16),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(shapes) { shape in
                viewModel.gridImage(for: shape.drawPath)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.primary)
            }
        }
        .animation(.easeIn, value: viewModel.gridShapes)
    }
}
