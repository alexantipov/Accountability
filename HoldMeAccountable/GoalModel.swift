//
//  GoalModel.swift
//  HoldMeAccountable
//
//  Created by Alex on 8/1/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

struct GoalModel {
    
    var goal : String
    var goalDate : NSDate
    var goalFailStatus : Int // 1 : "Run 2 Miles", 2 : "Sing a song in front of 10 strangers", 3 : "Buy My Supporter Coffee"
    var supporterName : String
    var supporterPhoneNumber : String
    
    init () {
        
        self.goal = ""
        self.goalDate = NSDate.distantPast() as NSDate
        self.goalFailStatus = 0
        self.supporterName = ""
        self.supporterPhoneNumber = ""
    }
}
