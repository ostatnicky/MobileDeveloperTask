//
//  DailyView.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import SwiftUI

struct DailyView: View {
    
    @StateObject var viewModel = DailyViewModel()
    let launch: Response
    
    var body: some View {
        VStack{
            Text(launch.title)
        }
        .onAppear{
            viewModel.fetch()
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Response(title: "title")
        DailyView(launch: sample)
    }
}
