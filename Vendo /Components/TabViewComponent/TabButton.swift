//
//  TabButton.swift
//  Vendo
//
//  Created by feras  hababa  on 21.08.24.
//

import Foundation
import SwiftUI

struct TabButton: View {
    let tab: Tab
    @Binding var currentTab: Tab
    var animation: Namespace.ID
    
    
    var badgeCount: Int = 0
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                currentTab = tab
            }
        }) {
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: currentTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
                        .resizable()
                        .foregroundStyle(Color("kPrimary"))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 27, height: 27)
                        .frame(maxWidth: .infinity)
                    
                    
                    if badgeCount > 0 {
                        Text("\(badgeCount)")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: -15, y: -0)
                    }
                }
                .background(
                    ZStack {
                        if currentTab == tab {
                            MaterialEffect(style: .systemChromeMaterial)
                                .clipShape(Circle())
                                .matchedGeometryEffect(id: "Tab", in: animation)
                        }
                    }
                )
                .contentShape(Rectangle())
                
                .offset(y: currentTab == tab ? -10 : 2)
            }
        }
        .frame(height: 25)
    }
}

