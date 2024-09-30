//
//  CustomTabBar.swift
//  Vendo
//
//  Created by feras hababa on 21.08.24.
//

import Foundation
import SwiftUI

/// Eine benutzerdefinierte TabBar-Ansicht, die mehrere Tabs mit Animation unterstützt.
struct CustomTabBar: View {
    @Binding var currentTab: Tab
    var animation: Namespace.ID

    var favoriteBadgeCount: Int
    var cartBadgeCount: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabButton(
                    tab: tab,
                    currentTab: $currentTab,
                    animation: animation,
                    badgeCount: badgeCount(for: tab)
                )
            }
        }
        .padding(.vertical)
        .padding(.bottom, getSafeArea().bottom > 0 ? getSafeArea().bottom - 0 : 5)
        .background(Color("kSecondery"))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 0)
    }

   
    private func badgeCount(for tab: Tab) -> Int {
        switch tab {
        case .Favorite:
            return favoriteBadgeCount
        case .Cart:
            return cartBadgeCount
        default:
            return 0
        }
    }
}

    
    // MARK: - Private Methods
    
    /// Bestimmt den Safe-Area-Inset des Geräts.
    /// - Returns: Die `UIEdgeInsets`, die die Safe Area darstellen.
    private func getSafeArea() -> UIEdgeInsets {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first?.safeAreaInsets ?? .zero
        }
        return .zero
    }


