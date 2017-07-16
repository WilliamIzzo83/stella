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
                                   image: .readyToWearDepartment,
                                   id: .readyToWear)
        case .accessories:
            return DepartmentModel(name: AppStrings.accessoriesTitle.get(),
                                   image: .accessoriesDepartment,
                                   id: .accessories)
        case .beauty:
            return DepartmentModel(name: AppStrings.beautyTitle.get(),
                                   image: .beautyDepartment,
                                   id: .beauty)
        case .lingerie:
            return DepartmentModel(name: AppStrings.lingerieTitle.get(),
                                   image: .lingerieDepartment,
                                   id: .lingerie)
        }
    }
}

class DepartmentDataProvider : GenericDataProvider<[DepartmentModel], Void> {
    override func retrieveData(request:(), didRetrieveDataCallback: @escaping ([DepartmentModel]?, Error?) -> Void) -> DataProviderToken {
        didRetrieveDataCallback([
            Department.readyToWear.model(),
            Department.accessories.model(),
            Department.beauty.model(),
            Department.lingerie.model()
            ], nil)
        return 0
    }
}
