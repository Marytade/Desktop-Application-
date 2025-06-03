//
//  ContentView.swift
//  Pin-proj
//
//  Created by Mary Adebayo on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentIndex = 0
    @State private var showButton = false

    // Your image asset names
    let imageNames = ["Desktop-1", "Desktop-2", "Desktop-3", "Desktop-4", "Desktop-5"]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Main image
            Image(imageNames[currentIndex])
                .resizable()
                .cornerRadius(10)
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .aspectRatio(contentMode: .fit)
                .frame(width: 1728, height: 1117)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5).delay(1.0)) {
                        showButton = true
                    }
                }

            // NEXT button with animation
            if showButton {
                Button(action: {
                    // Advance to next image and reset button
                    showButton = false
                    if currentIndex < imageNames.count - 1 {
                        currentIndex += 1
                    } else {
                        currentIndex = 0
                    }

                    // Trigger delayed button reappearance
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeIn(duration: 0.5).delay(1.0)) {
                            showButton = true
                        }
                    }
                }) {
                    Image("NEXT button")
                        .resizable()
                        .frame(width: 282, height: 282)
                        .padding()
                        .transition(.opacity)
                }
            }
        }
        .frame(width: 1728, height: 1117)
    }
}


#Preview {
    ContentView()
}
