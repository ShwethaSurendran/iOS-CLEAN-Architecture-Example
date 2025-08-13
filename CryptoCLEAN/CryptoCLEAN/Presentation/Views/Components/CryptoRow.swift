//
//  CryptoRow.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct CryptoRow: View {
    
    let crypto: Crypto
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: crypto.image) { image in
                image.resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(.circle)
                    .shadow(color: .gray.opacity(0.5), radius: 3)
                
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(crypto.name)
                    .font(.callout)
                    .bold()
                    .multilineTextAlignment(.leading)
                Text(crypto.symbol)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .foregroundStyle(.black)
            
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(crypto.currentPrice.toCurrency())
                    .font(.callout)
                    .bold()
                Text(crypto.priceChangePercentage.toPercentage())
                    .font(.caption)
                    .bold()
                    .foregroundStyle(crypto.priceChangePercentage > 0 ? .green : .red)
            }
        }
        .foregroundStyle(.black)
        .padding()
        .background(.white)
        .clipShape (
            RoundedRectangle(cornerRadius: 8)
        )
        .shadow(color: Color(.systemGray4).opacity(0.5), radius: 2, x: 1, y: -1)
        
    }
}

#Preview {
    CryptoRow(crypto: CryptoMockData.sampleCryptos.first!)
}
