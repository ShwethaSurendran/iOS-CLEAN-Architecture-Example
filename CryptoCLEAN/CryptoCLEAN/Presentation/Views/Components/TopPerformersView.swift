//
//  TopPerformersView.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct TopPerformersView: View {
    
    var topPerformers: [Crypto]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(AppConstants.topPerformers)
                .font(.title3)
                .bold()
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(topPerformers) { crypto in
                            VStack(alignment: .leading, spacing: 12) {
                                NavigationLink(value: crypto.id) {
                                    TopPerformerRowView(crypto: crypto)
                                }
                            }
                            
                            .frame(width: 120, height: 120)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            })
                        }
                    }
                    
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

struct TopPerformerRowView: View {
    
    var crypto: Crypto
    
    var body: some View {
        VStack {
            AsyncImage(url: crypto.image) { image in
                image.resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(.circle)
                    .shadow(color: .gray.opacity(0.5), radius: 3)

            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(crypto.symbol)
                    .font(.callout)
                    .bold()
                
                Text(crypto.priceChangePercentage.toPercentage())
                    .font(.caption)
                    .foregroundStyle(crypto.priceChangePercentage > 0 ? .green : .red)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    TopPerformersView(topPerformers: CryptoMockData.sampleCryptos)
}
