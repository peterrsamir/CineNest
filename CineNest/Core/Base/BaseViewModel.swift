//
//  BaseViewModel.swift
//  CineNest
//
//  Created by Peter on 06/06/2025.
//

import Foundation
import RxSwift

protocol BaseViewModelContract {
    var isLoading: PublishSubject<Bool> {get set}
    var errorObservable: PublishSubject<String> {get set}
}
