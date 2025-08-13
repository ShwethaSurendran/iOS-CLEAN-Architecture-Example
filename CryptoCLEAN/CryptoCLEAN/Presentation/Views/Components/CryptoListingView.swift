//
//  CryptoListingView.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct CryptoListingView: View {
    
    var cryptos: [Crypto]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(cryptos) { crypto in
                NavigationLink(value: crypto.id) {
                    CryptoRow(crypto: crypto)
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    CryptoListingView(cryptos: CryptoMockData.sampleCryptos)
}
