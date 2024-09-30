//
//  SecationHeader.swift
//  Vendo
//
//  Created by feras  hababa  on 11.09.24.
//

import SwiftUI

struct SectionHeader: View {
    
        let title: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.leading, 16)
        }
    }
