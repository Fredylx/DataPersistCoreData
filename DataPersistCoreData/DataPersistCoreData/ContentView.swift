//
//  ContentView.swift
//  DataPersistCoreData
//
//  Created by Nicky Taylor on 1/30/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var myText = ""
    var body: some View {
        VStack {
            Spacer()
            VStack {
                
                HStack {
                    TextField("Input Data", text: $myText)
                        .foregroundColor(.white)
                        .padding()
                }
                .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.gray))
                
                HStack(spacing: 12.0) {
                    Button {
                        Task {
                            await viewModel.saveDataIntent(dataString: myText)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save")
                                .padding()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.blue))
                    }
                    
                    Button {
                        Task {
                            if let dataString = await viewModel.loadDataIntent() {
                                await MainActor.run {
                                    myText = dataString
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Load")
                                .padding()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.blue))
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
