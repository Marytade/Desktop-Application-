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
    @State private var buttonEnabled = false
    @State private var sharedImage: Image? = nil
    @State private var showTutorial = !UserDefaults.standard.bool(forKey: "didCompleteTutorial")

    let imageNames = ["Desktop-1", "Desktop-2", "Desktop-3", "Desktop-4", "Desktop-5", "Tab-1", "Tab-2"]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            SlideView(imageName: imageNames[currentIndex])
                .onAppear {
                    animateButton()
                }

            // Drop zones
            if imageNames[currentIndex] == "Tab-1" {
                DropOverlayView(currentIndex: $currentIndex, sharedImage: $sharedImage)
                    .frame(width: 1529, height: 946)
                    .position(x: 240, y: 165)
            }

            if imageNames[currentIndex] == "Tab-2" {
                DropOverlayView(currentIndex: $currentIndex, sharedImage: $sharedImage)
                    .frame(width: 1545, height: 946)
                    .position(x: 240, y: 165)
            }

            // NEXT button for Desktop slides only
            if showButton && imageNames[currentIndex].starts(with: "Desktop") {
                Button(action: {
                    if !buttonEnabled { return }

                    showButton = false
                    buttonEnabled = false

                    if currentIndex == 4 {
                        // Completed Desktop-5 (tutorial end)
                        UserDefaults.standard.set(true, forKey: "didCompleteTutorial")
                        showTutorial = false
                        currentIndex = 5 // Jump to Tab-1
                    } else {
                        currentIndex += 1
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        animateButton()
                    }
                }) {
                    Image("NEXT button")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding()
                        .opacity(buttonEnabled ? 1.0 : 0.6)
                        .transition(.opacity)
                }
                .disabled(!buttonEnabled)
            }
        }
        .onAppear {
            // Jump to Tab-1 if tutorial was completed before
            if !showTutorial {
                currentIndex = 5 // Tab-1
            }
        }
        .frame(width: 480, height: 320)
    }

    private func animateButton() {
        withAnimation(.easeIn(duration: 0.5).delay(1.0)) {
            showButton = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            buttonEnabled = true
        }
    }
}




#Preview {
    ContentView()
}
