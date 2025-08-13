//
//  CryptoDashboard.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct CryptoDashboard: View {
    
    @State var viewModel: CryptoViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.loadingState {
                case .loading:
                    ProgressView()
                case .complete(let cryptos):
                    ScrollView(showsIndicators: false) {
                        //top performers view
                        VStack(spacing: 30) {
                            TopPerformersView(topPerformers: viewModel.getTopPerformers())
                            
                            //all listing
                            CryptoListingView(cryptos: cryptos)
                        }
                        .padding(.vertical)
                    }
                case .error(_):
                    Text(AppConstants.errorMessage)
                }
            }
            .padding(8)
            .navigationBarTitle(AppConstants.cryptoTracker)
            .navigationDestination(for: String.self) { cryptoId in
                CryptoDetailsView(cryptoId: cryptoId)
                    .environment(viewModel)
            }
        }
    }
}

#Preview {
    CryptoDashboard(viewModel: CryptoViewModel(cryptoUseCase: CryptoUseCaseMock()))
}
