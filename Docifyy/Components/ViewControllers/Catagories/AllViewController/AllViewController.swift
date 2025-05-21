//
//  AllViewController.swift
//  BookAppointment
//
//  Created by Mayank Jangid on 15/05/25.
//

import UIKit

class AllViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var doctors: [DoctorModel] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        doctors = DoctorData.getDoctorList()
        setupTableView()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        // 1) Add & pin
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        // 2) Register your XIB-based cell
        let nib = UINib(nibName: "DoctorTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DoctorTableViewCell")
        
        // 3) DataSource & Delegate
        tableView.dataSource = self
        tableView.delegate   = self
        
        // 4) Dynamic heights
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        // 5) Optional styling
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension AllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doctors.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "DoctorTableViewCell",
                                     for: indexPath) as? DoctorTableViewCell else {
            return UITableViewCell()
        }
        let doc = doctors[indexPath.row]
        cell.configureCell(data: doc)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AllViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let doc = doctors[indexPath.row]
        // e.g. push a detail view, or show available slots
        print("Selected doctor: \(doc.name ?? "Unknown")")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
