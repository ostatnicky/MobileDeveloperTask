//
//  DailyView.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import SwiftUI

struct DailyView: View {
    @State private var daily: Daily?
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ZStack{
                    if let imageUrl = URL(string: daily?.url ?? "") {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                                    .cornerRadius(10)
                            }
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        if let hdImageUrl = URL(string: daily?.hdurl ?? "") {
                            AsyncImage(url: hdImageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                EmptyView()
                            }
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    HStack{
                        VStack{
                            Text(daily?.copyright ?? "")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.top)
                            Spacer()
                            Text(daily?.date ?? "")
                                .foregroundColor(.white)
                                .padding(.leading)
                            Text("Today")
                                .foregroundColor(.white)
                                .font(.title.bold())
                                .padding(.bottom)
                        }
                        .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                
                Text(daily?.title ?? "")
                    .font(.largeTitle)
                Text(daily?.explanation ?? "")
            }
            .padding(30)
        }
        .task {
            do {
                daily = try await getDaily()
            } catch DailyError.invalidURL {
                print("Invalid url!")
            } catch DailyError.invalidResponse {
                print("Invalid response!")
            } catch DailyError.invalidData {
                print("Invalid data!")
            } catch {
                print("Unexpected error!")
            }
        }
        
    }
    
    func getDaily() async throws -> Daily {
        let endpoint = "https://api.nasa.gov/planetary/apod?api_key=zJyBH3jhtKmwTTvxa83aJV7gBioOq00jjHqfjNbG"
        
        guard let url = URL(string: endpoint) else { throw DailyError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw DailyError.invalidResponse}
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Daily.self, from: data)
        } catch {
            throw DailyError.invalidData
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}

struct Daily: Codable {
    let title: String
    let explanation: String
    let hdurl: String
    let url: String
    let copyright: String
    let date: String
}

enum DailyError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
