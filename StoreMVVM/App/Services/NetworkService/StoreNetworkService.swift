// StoreNetworkService.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Store API сервис
final class StoreNetworkService: NetworkServiceProtocol {
    // MARK: - Private Properties

    private let productDispatchGroup = DispatchGroup()
    private let productDetailDispatchGroup = DispatchGroup()
    private let semaphore = DispatchSemaphore(value: 1)

    // MARK: - Public Methods

    func fetchProductData(queryType: QueryType, completion: @escaping (Result<[Product], Error>) -> Void) {
        let urlString = "\(Constants.storeQueryText)\(queryType.rawValue)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if error == nil {
                guard let data = data else { return }
                do {
                    var decodedData: [Product]? = []
                    switch queryType {
                    case .latest:
                        decodedData = try JSONDecoder().decode(Products.self, from: data).latest
                    case .flashSale:
                        decodedData = try JSONDecoder().decode(Products.self, from: data).flashSale
                    default:
                        break
                    }
                    guard var decodedData = decodedData else { return }
                    for index in 0 ..< decodedData.count {
                        guard let imageURL = decodedData[index].imageURL else { return }
                        self.productDispatchGroup.enter()
                        self.fetchImage(queryText: imageURL) { result in
                            switch result {
                            case let .success(data):
                                decodedData[index].imageData = data
                                self.productDispatchGroup.leave()
                            case let .failure(error):
                                completion(.failure(error))
                            }
                        }
                    }
                    self.productDispatchGroup.notify(queue: .main) {
                        completion(.success(decodedData))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchProductDetailData(queryType: QueryType, completion: @escaping (Result<ProductDetail, Error>) -> Void) {
        let urlString = "\(Constants.storeQueryText)\(queryType.rawValue)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    var decodedData = try JSONDecoder().decode(ProductDetail.self, from: data)
                    decodedData.imageData = Array(repeating: nil, count: decodedData.imageUrls.count)
                    for index in 0 ..< decodedData.imageUrls.count {
                        self.productDetailDispatchGroup.enter()
                        self.fetchImage(queryText: decodedData.imageUrls[index]) { result in
                            switch result {
                            case let .success(data):
                                decodedData.imageData?[index] = data
                                self.productDetailDispatchGroup.leave()
                            case let .failure(error):
                                completion(.failure(error))
                            }
                        }
                    }
                    self.productDetailDispatchGroup.notify(queue: .main) {
                        completion(.success(decodedData))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchListWordsData(queryType: QueryType, completion: @escaping (Result<[String], Error>) -> Void) {
        let urlString = "\(Constants.storeQueryText)\(queryType.rawValue)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(ListWords.self, from: data).words
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Private Methods

    private func fetchImage(queryText: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: queryText) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                completion(.success(data))
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }
}
