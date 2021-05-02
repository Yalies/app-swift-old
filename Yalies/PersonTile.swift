//
//  PersonTile.swift
//  Yalies
//
//  Created by Tiger J. Wang on 3/29/21.
//

import SwiftUI

struct PersonTile: View {
    var person: YCStudent
    var body: some View {
        VStack {
            if let image = person.image {
                ImageView(image)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 100, height: 120)
            }
            
            Text("\(person.first_name) \(person.last_name)")
                .lineLimit(1)
                .allowsTightening(true)
            
            if let year = person.year {
                Text(String(year))
            }
        }
    }
}

struct PersonTile_Previews: PreviewProvider {
    static var previews: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
