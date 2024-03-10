//
//  DataRequest+ResponseData.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Alamofire
import Foundation

extension DataRequest {
	func responseDataAsync() async -> AFDataResponse<Data> {
		await withCheckedContinuation { continuation in
			responseData { response in
				continuation.resume(returning: response)
			}
		}
	}
}
