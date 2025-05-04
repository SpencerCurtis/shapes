//
//  ShapesGridView.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import SwiftUI

struct MainGridView: View {
    
    @StateObject private var viewModel: ShapeViewModel
    
    @State private var isShowingEditCirclesView = false
    
    init(shapeService: ShapeService) {
        _viewModel = StateObject(wrappedValue: .init(shapeService: shapeService))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ShapesGridView(viewModel: viewModel, shapes: viewModel.gridShapes)
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
            .navigationDestination(isPresented: $isShowingEditCirclesView) {
                EditCirclesView(viewModel: viewModel)
            }
        }
    }
    
    func clearAll() {
        viewModel.clearAllGridShapes()
    }
    
    func editCircles() {
        isShowingEditCirclesView = true
    }
    
    func add(shape: Shape) {
        viewModel.addShapeToGrid(shape.makeNewCopy())
    }
}

#Preview {
    MainGridView(shapeService: LocalShapeService())
}
