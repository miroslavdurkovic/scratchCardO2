//
//  ScratchCardManager.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 07/05/2023.
//

//MARK: - Imports
import Foundation

struct APIO2: Codable {
  let ios, iosTM, iosRA, iosRA2: String
  let android, androidTM, androidRA: String
  
  enum CodingKeys: String, CodingKey {
    case ios, iosTM, iosRA
    case iosRA2 = "iosRA_2"
    case android, androidTM, androidRA
  }
}

//MARK: - Class
class ScratchCardManager: ObservableObject {
  //MARK: - Properties
  @Published var scratchCard: ScratchCard = ScratchCard()
  var dataTask: URLSessionDataTask?

  //MARK: - Functions
  func wipeOff() {
    if( scratchCard.status == .new) {
      let uuid = UUID().uuidString
      scratchCard.code = String(uuid)
      scratchCard.status = .wiped
    }
  }
  
  func activateCard(_ completion:@escaping (ScratchCardStatus) -> Void) {
    if( scratchCard.status == .wiped) {
      dataTask?.cancel()
      
      let url = o2URL(code: scratchCard.code)

      let session = URLSession.shared
      dataTask = session.dataTask(with: url) {data, response, error in
        if let error = error as NSError?, error.code == -999 {
          return
        } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
          if let data = data {
            let version = self.parse(data: data)
            if(version.compare("6.1", options: .numeric) == .orderedDescending) {
              DispatchQueue.main.async {
                self.scratchCard.status = .active
                completion(.active)
              }
            } else {
              DispatchQueue.main.async {
                NotificationBanner.show("Sorry but version is below expected version")
              }
              
            }
            return
          }
        } else {
          print("Failure! \(response!)")
        }
      }
      dataTask?.resume()
    }
  }
  
  private func o2URL(code: String) -> URL {
    return URL(string: "https://api.o2.sk/version?"+"code=\(code)")!
  }
  
  private func parse(data: Data) -> String {
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(
        APIO2.self, from: data)
      return result.ios
    } catch {
      print("JSON Error: \(error)")
      return ""
    }
  }
}
