//
//  ShapesApp.swift
//  Shapes
//
//  Created by Spencer Curtis on 5/4/25.
//

import SwiftUI

@main
struct ShapesApp: App {
    var body: some Scene {
        WindowGroup {
            ShapesGridView(shapeService: RemoteShapeService())
        }
    }
}
