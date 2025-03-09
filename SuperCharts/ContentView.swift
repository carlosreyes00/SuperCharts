//
//  ContentView.swift
//  SuperCharts
//
//  Created by Carlos Reyes on 3/8/25.
//

import SwiftUI
import SwiftData
import Charts

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Point.x) private var points: [Point]

    var body: some View {
        VStack {
            Chart(points) { point in
                LineMark(
                    x: .value("label", point.x),
                    y: .value("value", point.y)
                )
            }
            .chartScrollableAxes(.horizontal)
            .padding()
            .onAppear {
                createPoints()
            }
            
            NavigationSplitView {
                List {
                    ForEach(points) { point in
                        NavigationLink {
                            VStack{
                                Text("Point: (x:\(point.x), y:\(point.y))")
                            }
                        } label: {
                            Text("(x:\(point.x), y:\(point.y))")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            } detail: {
                Text("Select an item")
            }
        }
    }
    
    private func createPoints() {
        for i in 0...100 {
            withAnimation {
                let newPoint = Point(
                    x: Double(i),
                    y: Double.random(in: 1...10)
                )
                modelContext.insert(newPoint)
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newPoint = Point(x: Double.random(in: 0...10), y: Double.random(in: 0...10))
            modelContext.insert(newPoint)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(points[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Point.self, inMemory: true)
}
