//
//  BuyView.swift
//  CryptoCLEAN
//
//

import SwiftUI

struct BuyView: View {
    
    var crypto: Crypto
    @State private var quantity: String = ""
    @Environment(CryptoViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 15) {
                    TextField(AppConstants.enterQuantity, text: $quantity)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 3)
                        .keyboardType(.numberPad)
                    
                    Button {
                        quantity = ""
                    } label: {
                        Text(AppConstants.reset)
                            .foregroundColor(.black)
                            .bold()
                    }

                }
                
                HStack {
                    Text(AppConstants.currentPrice)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(crypto.currentPrice.toCurrency())
                }
                .padding(.vertical)
                
                HStack {
                    Text(AppConstants.total)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(viewModel.getTotal(quantity: quantity, crypto: crypto).toCurrency())
                        .font(.title3)
                        .bold()
                }
                
                Spacer()
                
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
            .padding()
            .padding(.horizontal)
            .navigationTitle("\(AppConstants.buy) \(crypto.symbol)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if !quantity.isEmpty {
                            hideKeyboard()
                            showAlert.toggle()
                        }else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
            .alert(AppConstants.Alert.discardChanges, isPresented: $showAlert) {
                Button(AppConstants.Alert.yes, role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    BuyView(crypto: CryptoMockData.sampleCryptos.first!)
        .environment(CryptoViewModel(cryptoUseCase: CryptoUseCaseMock()))
}
