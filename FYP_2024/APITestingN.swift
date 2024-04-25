//
//  APITestingN.swift
//  FYP_2024
//
//  Created by Aaron Tso  on 25/4/2024.
//

import Foundation


struct Wrapper: Codable {
    let items: [Question]
}

struct Question: Codable {
    let score: Int
    let title: String
}

func performAPICall() async throws -> Question {
    let url = URL(string: "https://api.stackexchange.com/2.3/questions?pagesize=1&order=desc&sort=votes&site=stackoverflow&filter=)pe0bT2YUo)Qn0m64ED*6Equ")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
    return wrapper.items[0]
}


Task {
    try await performAPICall()
}
