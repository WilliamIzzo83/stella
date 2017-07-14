//
//  DepartmentDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation


extension Department {
    func model() -> DepartmentModel {
        switch self {
        case .readyToWear:
            return DepartmentModel(name: AppStrings.readyToWearTitle.get(),
                                   image: .readyToWearDepartment)
        case .accessories:
            return DepartmentModel(name: AppStrings.accessoriesTitle.get(),
                                   image: .accessoriesDepartment)
        case .beauty:
            return DepartmentModel(name: AppStrings.beautyTitle.get(),
                                   image: .beautyDepartment)
        case .lingerie:
            return DepartmentModel(name: AppStrings.lingerieTitle.get(),
                                   image: .lingerieDepartment)
        }
    }
}

class DepartmentDataProvider : IDataProvider {
    
    
    func retrieveData(didRetrieveDataCallback: @escaping DataProviderCompletionCallback) {
        didRetrieveDataCallback([
            Department.readyToWear.model(),
            Department.accessories.model(),
            Department.beauty.model(),
            Department.lingerie.model()
            ], nil)
    }
}
