//
//  Drop0verlayView.swift
//  Pin-proj
//
//  Created by Mary Adebayo on 6/3/25.
//

import SwiftUI
import UniformTypeIdentifiers
import AVKit

struct DropOverlayView: View {
    @Binding var currentIndex: Int
    @Binding var sharedImage: Image?

    @State private var droppedVideoURL: URL? = nil
    @State private var dropFailed = false

    // Positioning constants
    let buttonX: CGFloat = 210
    let buttonY: CGFloat = -18

    let vectorXOffsetX: CGFloat = 27
    let vectorXOffsetY: CGFloat = 0

    let sunLOffsetX: CGFloat = 73
    let sunLOffsetY: CGFloat = -143

    let moonDOffsetX: CGFloat = 75
    let moonDOffsetY: CGFloat = -160

    var body: some View {
        ZStack {
            if sharedImage == nil && droppedVideoURL == nil {
                // Glowing drop zone
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue.opacity(0.8), lineWidth: 4)
                    .shadow(color: Color.blue.opacity(0.7), radius: 20)
                    .frame(width: 420, height: 250)

                VStack {
                    Text("\u{1F4CE} Drop an image or video here")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.9))

                    if dropFailed {
                        Text("\u{26A0}\u{FE0F} Unsupported file. Try PNG, JPG, MOV, MP4")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 4)
                    }
                }
            }

            if let image = sharedImage {
                ZStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 230)
                        .cornerRadius(10)

                    ZStack {
                        Image("Tab-1 button")
                            .resizable()
                            .frame(width: 72.75, height: 19)

                        Button(action: {
                            sharedImage = nil
                            droppedVideoURL = nil
                            dropFailed = false
                        }) {
                            Image("Vector X")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .padding(10)
                        }
                        .offset(x: vectorXOffsetX, y: vectorXOffsetY)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .position(x: buttonX, y: buttonY)
                }
                .frame(width: 420, height: 250)
            }

            if let videoURL = droppedVideoURL {
                ZStack {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(width: 400, height: 230)
                        .cornerRadius(10)

                    ZStack {
                        Image("Tab-2 button")
                            .resizable()
                            .frame(width: 72.75, height: 19)

                        Button(action: {
                            droppedVideoURL = nil
                            sharedImage = nil
                            dropFailed = false
                        }) {
                            Image("Vector X")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .padding(10)
                        }
                        .offset(x: vectorXOffsetX, y: vectorXOffsetY)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .position(x: buttonX, y: buttonY)
                }
                .frame(width: 420, height: 250)
            }

            if currentIndex == 5 { // Tab-1
                Image("Sun-L")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .offset(x: sunLOffsetX, y: sunLOffsetY)
                    .onTapGesture {
                        currentIndex = 6 // Go to Tab-2
                    }
            } else if currentIndex == 6 { // Tab-2
                Image("Moon-D")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .offset(x: moonDOffsetX, y: moonDOffsetY)
                    .onTapGesture {
                        currentIndex = 5 // Go back to Tab-1
                    }
            }

            Color.clear
                .frame(width: 420, height: 250)
                .contentShape(Rectangle())
                .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                    handleFileDrop(providers: providers)
                }
        }
    }

    func handleFileDrop(providers: [NSItemProvider]) -> Bool {
        dropFailed = false
        guard let provider = providers.first else { return false }

        provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, _ in
            DispatchQueue.main.async {
                guard let data = item as? Data,
                      let url = URL(dataRepresentation: data, relativeTo: nil) else {
                    dropFailed = true
                    return
                }

                if ["mp4", "mov", "m4v"].contains(url.pathExtension.lowercased()) {
                    droppedVideoURL = url
                    sharedImage = nil
                } else if ["png", "jpg", "jpeg"].contains(url.pathExtension.lowercased()) {
                    if let nsImage = NSImage(contentsOf: url) {
                        sharedImage = Image(nsImage: nsImage)
                        droppedVideoURL = nil
                    } else {
                        dropFailed = true
                    }
                } else {
                    dropFailed = true
                }
            }
        }
        return true
    }
}



#Preview {
    ContentView()
}
