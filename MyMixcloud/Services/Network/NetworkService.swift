//
//  NetworkService.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 31.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

protocol NetworkService {
    /**
     Отправляет запрос на сервер для получения данных нужного типа
     - Parameter url: url запроса
     - Returns: сетевая модель (декодированный json)
     - Throws: MMError
     */
    func data<T: Decodable>(url: URL) async throws -> T
}
