//
//  ShapesGridView.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import SwiftUI

struct ShapesGridView: View {
    
    @StateObject private var viewModel: ShapeViewModel
    
    init(shapeService: ShapeService) {
        _viewModel = StateObject(wrappedValue: .init(shapeService: shapeService))
    }
    
    private let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 16),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                shapesGrid()
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear All", action: clearAll)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit Circles", action: editCircles)
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    ForEach(viewModel.shapeButtons) { shape in
                        Spacer()
                        Button(action: { add(shape: shape) }) {
                            Text(shape.name)
                        }
                        Spacer()
                    }
                }
            }
            .task {
                try? await viewModel.loadShapes()
            }
        }
    }
    
    func shapesGrid() -> some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.gridShapes) { shape in
                viewModel.gridImage(for: shape.drawPath)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.blue)
            }
        }
        .animation(.easeIn, value: viewModel.gridShapes)
    }
    
    func clearAll() {
        viewModel.clearAllGridShapes()
    }
    
    func editCircles() {
        
    }
    
    func add(shape: Shape) {
        viewModel.addShapeToGrid(shape.makeNewCopy())
    }
}

#Preview {
    ShapesGridView(shapeService: LocalShapeService())
}
