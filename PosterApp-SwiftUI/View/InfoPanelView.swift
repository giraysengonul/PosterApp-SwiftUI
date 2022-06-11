//
//  InfoPanelVıew.swift
//  PosterApp-SwiftUI
//
//  Created by hakkı can şengönül on 11.06.2022.
//

import SwiftUI

struct InfoPanelView: View {
    // MARK: - PROPERTIES
    var scale: CGFloat
    var offset: CGSize
    @State private var isInfoPanelVisible : Bool = false
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration:1){
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            HStack{
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                Spacer()
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth:420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            Spacer()
        }
    }
}

// MARK: - PREVIEW
struct InfoPanelV_ew_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero).previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .padding()
    }
}
