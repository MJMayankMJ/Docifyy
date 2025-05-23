//
//  DoctorModel.swift
//  BookAppointment
//
//  Created by Mayank Jangid on 15/05/25.
//

import Foundation

struct DoctorModel {
    let name: String?
    let speciality: String?
    let rating: String?
    let image: String?
    let workExp: String?
    let totalPatient: String?
    let reviews: String?
    let about: String?
    let date: DateData?
    let day: DaysData?
    let hours: VisitHour?
}

struct DateData {
    let dateText: [String]?
}
struct DaysData {
    let dayText: [String]?
}
struct VisitHour {
    let hour: [String]?
}
