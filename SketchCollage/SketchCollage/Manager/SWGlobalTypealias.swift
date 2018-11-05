//
//  SWGlobalTypealias.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/21.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import Foundation

typealias SWSucceedTypealias = (_ model: SWSucceedParamsStruct<Any>) -> Void
typealias SWErrorTypealias = (_ errorMsg : String) -> Void

typealias SWSucceedMultiTypealias = (_ model: SWSucceedMultiParamsStruct<Any>) -> Void
