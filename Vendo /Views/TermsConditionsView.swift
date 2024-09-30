//
//  TermsConditionsView.swift
//  Vendo
//
//  Created by feras  hababa  on 23.09.24.
//

import SwiftUI

struct TermsConditionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Terms & Conditions")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("""
                Welcome to Vendo! By using our app, you agree to the following terms and conditions.
                
                **1. Account Usage:**
                You are responsible for keeping your account credentials secure. Any activity under your account is your responsibility.

                **2. Orders and Payments:**
                All orders placed through Vendo are subject to our order and cancellation policies. Ensure your payment information is accurate.

                **3. Refunds:**
                Refunds are issued in accordance with our refund policy, which can be accessed from the app settings.

                **4. Updates and Changes:**
                We may update these terms from time to time. You will be notified of any changes via email or through the app.

                For more details, please visit our [website](https://www.vendoapp.com/terms).
                """)
                .font(.body)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Terms & Conditions")
        .background(Color(UIColor.systemGray6))
    }
}
