//
//  ViewController.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-07.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var carsTableView: UITableView!
    @IBOutlet weak var sortPickerView: UIPickerView!
    @IBOutlet weak var sortButton: UIButton!
    
    // simulate infinite scrolling
    static let maxRowCount = 999999

    private var presenter: MainPresenter!
    private var cars = [CarViewModel]()
    private var sortOptions = [String]()
    
    static func instance() -> MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        view.presenter = MainPresenter(view: view, interactor:  MainInteractor(), router: MainRouter())
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsTableView.dataSource = self
        carsTableView.rowHeight = UITableView.automaticDimension
        carsTableView.estimatedRowHeight = 300

        sortPickerView.dataSource = self
        sortPickerView.delegate = self

        presenter.onStart()
    }

    @IBAction func onSortButtonPressed(_ sender: Any) {
        presenter.onSort()
    }
}

extension MainViewController {
    func showCars(_ cars: [CarViewModel]) {
        self.cars = cars
        carsTableView.reloadData()
    }
    
    func showSortOptions(_ options: [String], current: String) {
        self.sortOptions = options
        sortPickerView.isHidden = false
        sortPickerView.reloadAllComponents()
    }
    
    func setSort(_ option: String) {
        sortButton.setTitle(option, for: UIControl.State.normal)
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.onSortOptionSelected(sortOptions[row])
        sortPickerView.isHidden = true
    }
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOptions[row]
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cars.isEmpty {
            return 0
        } else {
            return MainViewController.maxRowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row % cars.count
        let cell = carsTableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        let car = cars[row]
        cell.showCar(car)
        presenter.onCarShows(carViewModel: car)
        return cell
    }
}
