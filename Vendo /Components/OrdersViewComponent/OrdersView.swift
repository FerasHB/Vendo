//
//  OrdersView.swift
//  Vendo
//
//  Created by feras  hababa  on 22.09.24.
//
import SwiftUI

struct OrdersView: View {
    @ObservedObject var ordersManager: OrderViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if ordersManager.orders.isEmpty {
                    VStack {
                        Spacer()
                        Image(systemName: "tray.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)

                        Text("No Orders Yet")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        ForEach(ordersManager.orders) { order in
                            OrderRow(order: order)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle(Text("My Orders"))
            .onAppear {
                ordersManager.fetchOrders()
            }
        }
    }
}

#Preview {
    OrdersView(ordersManager: OrderViewModel())
}
