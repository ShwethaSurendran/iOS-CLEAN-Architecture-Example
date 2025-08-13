//
//  CryptoDetailsView.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct CryptoDetailsView: View {
    
    var cryptoId: String
    @Environment(\.dismiss) var dismiss
    @Environment(CryptoViewModel.self) var viewModel
    @State private var showBuyModal: Bool = false
    @State private var showWatchlistAlert: Bool = false
    
    var body: some View {
        if let crypto = viewModel.cryptos.first(where: { $0.id == cryptoId }) {
            ScrollView {
                
                VStack(alignment: .leading) {
                    HStack(spacing: 20){
                        AsyncImage(url: crypto.image) { image in
                            image
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(.circle)
                                .shadow(color: .gray.opacity(0.5), radius: 3)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading) {
                            Text(crypto.name)
                                .font(.title2)
                                .bold()
                            Text(crypto.symbol)
                                .font(.title3)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        
                        Button {
                            //add to watchlist
                            viewModel.toggleWatchlist(crypto)
                            showWatchlistAlert.toggle()
                        } label: {
                            Image(systemName: crypto.isInWatchlist ? "heart.fill" : "heart")
                        }
                        
                    }
                }
                .padding(.horizontal)
                
                //chart view
                ChartView(dataPoints: crypto.chartData)
                
                //details
                VStack(alignment: .leading, spacing: 12) {
                    
                    VStack(alignment: .leading) {
                        Text(AppConstants.overview)
                            .font(.title2)
                            .bold()
                        
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(AppConstants.currentPrice)
                                    .foregroundStyle(.gray)
                                    .font(.callout)
                                    .bold()
                                
                                Text(crypto.currentPrice.toCurrency())
                                    .bold()
                                Text(crypto.priceChangePercentage.toPercentage())
                                    .font(.footnote)
                                    .foregroundStyle(crypto.priceChangePercentage > 0 ? .green : .red)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 8) {
                                Text(AppConstants.marketCap)
                                    .foregroundStyle(.gray)
                                    .font(.callout)
                                    .bold()
                                
                                Text(crypto.marketCap.toCurrency())
                                    .bold()
                                Text(crypto.marketCapPercentage.toPercentage())
                                    .font(.footnote)
                                    .foregroundStyle(crypto.marketCapPercentage > 0 ? .green : .red)
                            }
                            
                        }
                        .padding(.vertical, 8)
                    }
                    .padding(5)
                    
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text(AppConstants.additionalDetails)
                            .font(.title2)
                            .bold()
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(AppConstants.high24h)
                                    .foregroundStyle(.gray)
                                    .font(.callout)
                                    .bold()
                                
                                Text(crypto.high24h.toCurrency())
                                    .bold()
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 8) {
                                Text(AppConstants.low24h)
                                    .foregroundStyle(.gray)
                                    .font(.callout)
                                    .bold()
                                
                                Text(crypto.low24h.toCurrency())
                                    .bold()
                            }
                            
                        }
                        .padding(.vertical, 8)
                        
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(AppConstants.priceChange24h)
                                    .foregroundStyle(.gray)
                                    .font(.callout)
                                    .bold()
                                
                                Text(crypto.priceChange24h.toCurrency())
                                    .bold()
                                Text(crypto.priceChangePercentage.toPercentage())
                                    .font(.footnote)
                                    .foregroundStyle(crypto.priceChangePercentage > 0 ? .green : .red)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 8) {
                                Text(AppConstants.marketCapChange24h)
                                    .foregroundStyle(.gray)
                                    .font(.callout)
                                    .bold()
                                
                                Text(crypto.marketCapChange24h.toCurrency())
                                    .bold()
                                Text(crypto.marketCapPercentage.toPercentage())
                                    .font(.footnote)
                                    .foregroundStyle(crypto.marketCapPercentage > 0 ? .green : .red)
                            }
                            
                        }
                        .padding(.vertical)
                        
                    }
                }
                .padding()
                
                
                Spacer(minLength: 80)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .overlay(alignment: .bottom) {
                Button {
                    showBuyModal.toggle()
                } label: {
                    Text(AppConstants.buy)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                }
            }
            .sheet(isPresented: $showBuyModal) {
                //Model View
                BuyView(crypto: crypto)
                    .presentationDetents([.height(350)])
            }
            .alert(isPresented: $showWatchlistAlert) {
                Alert(title: Text("\(crypto.symbol) \(crypto.isInWatchlist ? AppConstants.addToWatchlist : AppConstants.removeFromWatchlist)"), dismissButton: .cancel())

            }
        } else {
            Text(AppConstants.cryptoNotFound)
        }
    }
}

#Preview {
    CryptoDetailsView(cryptoId: "")
        .environment(CryptoViewModel(cryptoUseCase: CryptoUseCaseMock()))
}
