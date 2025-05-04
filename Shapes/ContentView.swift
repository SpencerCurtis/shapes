//
//  ContentView.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ShapeViewModel(shapeService: RemoteShapeService())
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            try? await viewModel.loadShapes()
            print(viewModel.shapeButtons)
        }
    }
}

#Preview {
    ContentView()
}
