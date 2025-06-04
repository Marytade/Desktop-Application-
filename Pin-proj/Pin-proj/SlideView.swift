//
//  SlideView.swift
//  Pin-proj
//
//  Created by Mary Adebayo on 6/3/25.
//

import SwiftUI

struct SlideView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 480, height: 320)
    }
}
