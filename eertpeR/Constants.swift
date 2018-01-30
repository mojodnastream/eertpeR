//
//  Constants.swift
//  eertpeR
//
//  Created by Gary Nothom on 8/2/16.
//  Copyright © 2016 Mojo Services. All rights reserved.
//

import Foundation


typealias JSONDictionary = [String: AnyObject]
typealias JSONArray = Array<AnyObject>

let WIFI = "WIFI Available"
let NOACCESS = "No Internet Access"
let WWAN = "Cellular Access Available"

var feedbackEmail = "gnothom@gmail.com"
var arrSkills = [String]()
var arrSkillsSearchResults = [String]()
var arrSkillsForUser = [String]()
var arrSkillsSignUp = [String]()
var arrSkillsProfileUsage = [String]()
var arrBadgesProfileUsage = [String]()
var arrBadges = [String]()
var arrSearchResults = [String]()
var arrSkillClassArray = [Skill()]
var arrUserClassArray = [RTUser()]
var arrFollowingClassArray = [Following()]
var arrFollowing [String]()

//User Basics
var userRealName = ""
var userEmail = ""
var userID = ""
var constUserCompany = ""
var constUserTitleRole = ""
var constUserLocation = ""
var constProfilePicUrl = ""

//User Rep Factors
var userBadges = 0
var userReps = 0
var userSkills = 0

