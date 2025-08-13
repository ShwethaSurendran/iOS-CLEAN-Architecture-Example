//
//  TabView.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct TabBarView: View {
    
    let viewModel = AppContainer().makeCryptosViewModel()
    
    var body: some View {
        TabView {
            Tab {
                CryptoDashboard(viewModel: viewModel)
            } label: {
                Image(systemName: "house.fill")
            }
            
            Tab {
                WatchlistView(viewModel: viewModel)
            } label: {
                Image(systemName: "heart")
            }
        }
        .tint(.black)
    }
}

#Preview {
    TabBarView()
}
