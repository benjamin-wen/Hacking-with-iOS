//
//  GridStack.swift
//  ViewsAndModifiers
//
//  Created by Zhishen Wen on 8/6/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let spacing: CGFloat
    /// (row, column) -> Content
    let content: (Int, Int) -> Content
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<columns) { column in
                VStack(spacing: self.spacing) {
                    ForEach(0..<self.rows) { row in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(
        rows: Int,
        columns: Int,
        spacing: CGFloat,
        @ViewBuilder content: @escaping (Int, Int) -> Content
    ) {
        self.rows = rows
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }
}

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack(rows: 5, columns: 3, spacing: 5) { (row, column) in
            VStack {
                Image(systemName: "\(row).circle")
                Text("R\(row)-C\(column) ")
                Image(systemName: "\(column).circle")
            }
            .foregroundColor(.white)
            .frame(width: 90, height: 90, alignment: .center)
            .background((row + column) % 3 == 0 ? Color.green : Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
