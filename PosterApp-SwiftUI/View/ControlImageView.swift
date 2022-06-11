//
//  ControlImageView.swift
//  PosterApp-SwiftUI
//
//  Created by hakkı can şengönül on 11.06.2022.
//

import SwiftUI

struct ControlImageView: View {
    // MARK: - PROPERTIES
    let icon : String
    
    // MARK: - BODY
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

// MARK: - PREVIEW
struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass").previewLayout(.sizeThatFits)
            .padding().preferredColorScheme(.dark)
    }
}
