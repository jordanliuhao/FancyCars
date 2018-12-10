//
//  MainPresenter.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-07.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import Foundation
import RxSwift

class MainPresenter {
    static let sortByName = "Name"
    static let sortByAvailability = "Available"
    
    private let interactor: MainInteractor
    private let router: MainRouter
    private weak var view: MainViewController?
    
    private var carsViewModel = [CarViewModel]()
    private var sortBy = sortByName
    
    private let disposeBag = DisposeBag()
    
    init(view: MainViewController, interactor: MainInteractor, router: MainRouter) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func onStart() {
        loadCars()
        view?.setSort(sortBy)
    }
    
    private func loadCars() {
        interactor.loadCars()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map({ [unowned self] cars in
                self.carsToViewModel(cars)
            })
            .map({ [unowned self] carsViewModel in
                if self.sortBy == MainPresenter.sortByName {
                    return carsViewModel.sorted(by: { (car1, car2) -> Bool in
                        return car1.name < car2.name
                    })
                } else {
                    return carsViewModel
                }
            })
            .do(onNext: { [unowned self] carsViewModel in
                self.carsViewModel = carsViewModel
            })
            .observeOn(MainScheduler())
            .do(onNext: { [unowned self] carsViewModel in
                self.view?.showCars(carsViewModel)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func onCarShows(carViewModel: CarViewModel) {
        if carViewModel.id == 0 {
            return
        }
        
        interactor.getCarAvailable(id: carViewModel.id)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .do(onSuccess: { [unowned self] availability in
                self.showIfVisibilityChanged(carViewModel: carViewModel, availability: availability)
            })
            .subscribe()
            .disposed(by: disposeBag)

    }
    
    func onSort() {
        view?.showSortOptions([MainPresenter.sortByName, MainPresenter.sortByAvailability], current: sortBy)
    }
    
    func onSortOptionSelected(_ option: String) {
        sortBy = option
        if sortBy == MainPresenter.sortByAvailability {
            carsViewModel = carsViewModel.sorted(by: {$0.buyVisible && !$1.buyVisible})
        } else {
            carsViewModel = carsViewModel.sorted(by: {$0.name < $1.name})
        }
        view?.setSort(sortBy)
        view?.showCars(carsViewModel)
    }
    
    private func showIfVisibilityChanged(carViewModel: CarViewModel, availability: Availability) {
        for i in 0..<self.carsViewModel.count {
            if self.carsViewModel[i].id == carViewModel.id {
                let visibility = (availability.available == Availability.inDealership)
                if self.carsViewModel[i].buyVisible != visibility {
                    let updatedCarViewModel = CarViewModel(
                        id: carViewModel.id,
                        photo: carViewModel.photo,
                        name: carViewModel.name,
                        make: carViewModel.make,
                        model: carViewModel.model,
                        buyVisible: visibility)
                    self.carsViewModel[i] = updatedCarViewModel
                    if sortBy == MainPresenter.sortByAvailability {
                        carsViewModel = carsViewModel.sorted(by: { $0.buyVisible && !$1.buyVisible})
                    }
                    self.view?.showCars(self.carsViewModel)
                }
                break
            }
        }
    }
    
    private func carToViewModel(_ car: Car) -> CarViewModel {
        let viewModel = CarViewModel(
            id: car.id,
            photo: car.img,
            name: car.name,
            make: car.make,
            model: car.model,
            buyVisible: false)
        return viewModel
    }
    
    private func carsToViewModel(_ cars: [Car]) -> [CarViewModel] {
        var carViewModels = [CarViewModel]()
        for car in cars {
            carViewModels += [carToViewModel(car)]
        }
        return carViewModels
    }
}
