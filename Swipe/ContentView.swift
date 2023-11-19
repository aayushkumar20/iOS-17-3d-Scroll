//
//  ContentView.swift
//  Swipe
//
//  Created by Aayush kumar on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var colors : [Color] = [.blue, .red, .green, .yellow, .brown, .mint, .indigo, .pink, .teal]
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                VStack(items: colors){ color in
                    ZStack{
                        RoundedRectangle(cornerRadius: 24.0)
                            .fill(color.gradient)
                        RoundedRectangle(cornerRadius: 24.0)
                            .stroke(color, style: .init(lineWidth: 8))
                            .background(.clear)
                    }
                }

            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("Vertical scroll")
            .navigationBarTitleDisplayMode(.large)
            .background(Color.black.gradient)
        }
        .preferredColorScheme(.dark)
    }
}

struct VStack<T: Hashable, Content: View>: View  {
    
    // MARK: - Properties
    
    let items: [T]
    
    let content: (T) -> Content
    
    // MARK: - Life circle

    var body: some View {
            LazyVStack(spacing: 5, content: itemsTpl)
            .padding(24)
            .scrollTargetLayout()
    }
    
    // MARK: - Template
    
    private func itemsTpl() -> some View {
        ForEach(items, id : \.hashValue) { item in
            content(item)
            .containerRelativeFrame(
                .vertical,
                count: 11,
                span: 7,
                spacing: 24
            )
            .scrollTransition { content, phase in
                content
                    .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 60), axis: (-1, 1, 0))
                    .rotationEffect(.degrees(phase.isIdentity ? 0 : -30))
                    .offset(x: phase.isIdentity ? 0 : -200)
                    .blur(radius: phase.isIdentity ? 0 : 5)
                    .scaleEffect(phase.isIdentity ? 1 : 0.7)
                    .opacity(phase.isIdentity ? 1 : 0)
            }
        }
    }
}

#Preview {
    ContentView()
}
