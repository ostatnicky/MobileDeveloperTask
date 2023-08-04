//
//  LaunchesView.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import SwiftUI

struct LaunchesView: View {
    
    @ObservedObject var viewModel: LaunchesViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LaunchesView(viewModel: LaunchesViewModel())
}
