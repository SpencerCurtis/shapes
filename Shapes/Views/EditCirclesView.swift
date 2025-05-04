//
//  EditCirclesView.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import SwiftUI

struct EditCirclesView: View {
    
    @ObservedObject var viewModel: ShapeViewModel
    
    var body: some View {
        ScrollView {
            ShapesGridView(viewModel: viewModel, shapes: viewModel.circleGridShapes)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Delete All", action: deleteAll)
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button("Add", action: appendCircle)
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button("Remove", action: removeLastCircle)
            }
        }
    }
    
    func deleteAll() {
        viewModel.deleteAllCircles()
    }
    
    func appendCircle() {
        viewModel.appendCircle()
    }
    
    func removeLastCircle() {
        viewModel.removeLastCircle()
    }
}

#Preview {
    EditCirclesView(viewModel: ShapeViewModel(shapeService: LocalShapeService()))
}
