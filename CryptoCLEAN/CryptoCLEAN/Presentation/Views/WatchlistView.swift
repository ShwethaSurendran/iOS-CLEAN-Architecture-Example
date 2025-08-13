//
//  WatchlistView.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct WatchlistView: View {
    
    @State var viewModel: CryptoViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                let items = viewModel.getWatchlist()
                
                if items.isEmpty {
                    Text(AppConstants.watchlistEmpty)
                } else {
                    CryptoListingView(cryptos: items)
                    Spacer()
                }
            }
            .navigationTitle(AppConstants.watchlist)
            .navigationDestination(for: String.self) { cryptoId in
                CryptoDetailsView(cryptoId: cryptoId)
                    .environment(viewModel)
            }
        }
    }
}

#Preview {
    WatchlistView(viewModel: CryptoViewModel(cryptoUseCase: CryptoUseCaseMock()))
}
