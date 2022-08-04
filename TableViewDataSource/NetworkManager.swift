//
//  NetworkManager.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/03.
//

import Foundation
import RxSwift
import Alamofire

final class NetworkManager {
    static let shared: NetworkManager = NetworkManager()

    func requestJsonHolder<T: Codable>(
        url: URL?,
        type: T.Type
    ) -> Observable<T> {
        return Observable.create { emitter in
            guard let url = url else { return Disposables.create() }
            AF.request(
                url,
                method: .get
            ).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    emitter.onNext(data)
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
