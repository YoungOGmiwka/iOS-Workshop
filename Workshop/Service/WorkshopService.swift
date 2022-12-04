//
//  WorkshopService.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation

private extension String {
    static let usersUrl = "https://jsonplaceholder.typicode.com/users"
    static let postsUrl = "https://jsonplaceholder.typicode.com/posts"
}

enum WorkshopServiceError: String, Error{
    case nonValidUrl = "Неправильный URL-адрес"
    case noValidData = "Ошибка в загруженных данных"
    case decodeError = "Не удалось обработать данные"
}

protocol IWorkshopService: AnyObject {
    func loadUsers(_ completion: @escaping (Result<[User], Error>) -> Void)
    func loadPosts(_ completion: @escaping (Result<[Post], Error>) -> Void)
}

class WorkshopService {}

// MARK: - IWorkshopService

extension WorkshopService: IWorkshopService {
    func loadUsers(_ completion: @escaping (Result<[User], Error>) -> Void) {
        // Создаем URL запроса
        guard let url = URL(string: .usersUrl) else {
            completion(.failure(WorkshopServiceError.nonValidUrl))
            return
        }
        let request = URLRequest(url: url)
        // Создаем задачу в URLSession на выполнение GET-запроса
        URLSession.shared.dataTask(with: request) { data, _, error in
            // Проверяем ошибку от запросы
            if let error = error {
                completion(.failure(error))
                return
            }
            // проверяем пришли ли данные из запроса
            guard let data = data else {
                completion(.failure(WorkshopServiceError.noValidData))
                return
            }
            // Парсим JSON в наши структуры для дальнейшей работы
            let users = try? JSONDecoder().decode([User].self, from: data)
            if let users = users {
                completion(.success(users))
            } else {
                completion(.failure(WorkshopServiceError.decodeError))
            }
        }.resume()
    }
    
    func loadPosts(_ completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: .postsUrl) else {
            completion(.failure(WorkshopServiceError.nonValidUrl))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(WorkshopServiceError.noValidData))
                return
            }
            if let posts = try? JSONDecoder().decode([Post].self, from: data) {
                completion(.success(posts))
            } else {
                completion(.failure(WorkshopServiceError.decodeError))
            }
        }.resume()
    }
}
