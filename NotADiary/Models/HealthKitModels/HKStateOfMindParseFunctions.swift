////
////  enum.swift
////  NotADiary
////
////  Created by Vinicius Alves Marques on 15/10/25.
////
//import HealthKit
//
//class HKStateOfMindParseFunctions{
//    
//    public static let shared = HKStateOfMindParseFunctions()
//    
//    func labelStringToHKStateOfMind (string: String) -> HKStateOfMind.Label{
//        switch(string){
//        case"Amazed":
//            return HKStateOfMind.Label.amazed
//        case"Amused":
//            return HKStateOfMind.Label.amused
//        case"Angry":
//            return HKStateOfMind.Label.angry
//        case"Annoyed":
//            return HKStateOfMind.Label.annoyed
//        case"Anxious":
//            return HKStateOfMind.Label.anxious
//        case"Ashamed":
//            return HKStateOfMind.Label.ashamed
//        case"Brave":
//            return HKStateOfMind.Label.brave
//        case"Calm":
//            return HKStateOfMind.Label.calm
//        case"Confident":
//            return HKStateOfMind.Label.confident
//        case"Content":
//            return HKStateOfMind.Label.content
//        case"Disappointed":
//            return HKStateOfMind.Label.disappointed
//        case"Discouraged":
//            return HKStateOfMind.Label.discouraged
//        case"Disgusted":
//            return HKStateOfMind.Label.disgusted
//        case"Drained":
//            return HKStateOfMind.Label.drained
//        case"Embarrassed":
//            return HKStateOfMind.Label.embarrassed
//        case"Excited":
//            return HKStateOfMind.Label.excited
//        case"Frustrated":
//            return HKStateOfMind.Label.frustrated
//        case"Grateful":
//            return HKStateOfMind.Label.grateful
//        case"Guilty":
//            return HKStateOfMind.Label.guilty
//        case"Happy":
//            return HKStateOfMind.Label.happy
//        case"Hopeful":
//            return HKStateOfMind.Label.hopeful
//        case"Hopeless":
//            return HKStateOfMind.Label.hopeless
//        case"Indifferent":
//            return HKStateOfMind.Label.indifferent
//        case"Irritated":
//            return HKStateOfMind.Label.irritated
//        case"Jealous":
//            return HKStateOfMind.Label.jealous
//        case"Joyful":
//            return HKStateOfMind.Label.joyful
//        case"Lonely":
//            return HKStateOfMind.Label.lonely
//        case"Overwhelmed":
//            return HKStateOfMind.Label.overwhelmed
//        case"Passionate":
//            return HKStateOfMind.Label.passionate
//        case"Peaceful":
//            return HKStateOfMind.Label.peaceful
//        case"Proud":
//            return HKStateOfMind.Label.proud
//        case"Relieved":
//            return HKStateOfMind.Label.relieved
//        case"Sad":
//            return HKStateOfMind.Label.sad
//        case"Satisfied":
//            return HKStateOfMind.Label.satisfied
//        case"Scared":
//            return HKStateOfMind.Label.scared
//        case"Stressed":
//            return HKStateOfMind.Label.stressed
//        case"Surprised":
//            return HKStateOfMind.Label.surprised
//        case"Worried":
//            return HKStateOfMind.Label.worried
//        default:
//            return HKStateOfMind.Label.worried
//        }
//    }
//    
//    func associationStringToHKStateOfMind (string: String) -> HKStateOfMind.Association {
//        switch(string){
//        case"Community":
//            return HKStateOfMind.Association.community
//        case"Current Events":
//            return HKStateOfMind.Association.currentEvents
//        case"Dating":
//            return HKStateOfMind.Association.dating
//        case"Education":
//            return HKStateOfMind.Association.education
//        case"Family":
//            return HKStateOfMind.Association.family
//        case"Fitness":
//            return HKStateOfMind.Association.fitness
//        case"Friends":
//            return HKStateOfMind.Association.friends
//        case"Health":
//            return HKStateOfMind.Association.health
//        case"Hobbies":
//            return HKStateOfMind.Association.hobbies
//        case"Identity":
//            return HKStateOfMind.Association.identity
//        case"Money":
//            return HKStateOfMind.Association.money
//        case"Partner":
//            return HKStateOfMind.Association.partner
//        case"Self Care":
//            return HKStateOfMind.Association.selfCare
//        case"Spirituality":
//            return HKStateOfMind.Association.spirituality
//        case"Tasks":
//            return HKStateOfMind.Association.tasks
//        case"Travel":
//            return HKStateOfMind.Association.travel
//        case"Weather":
//            return HKStateOfMind.Association.weather
//        case"Work":
//            return HKStateOfMind.Association.work
//        default:
//            return HKStateOfMind.Association.work
//        }
//    }
//}
