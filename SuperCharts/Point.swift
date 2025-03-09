//
//  Item.swift
//  SuperCharts
//
//  Created by Carlos Reyes on 3/8/25.
//

import Foundation
import SwiftData

@Model
final class Point {
    var x: Double
    var y: Double
    
    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
}
