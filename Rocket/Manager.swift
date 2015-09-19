//
//  Manager.swift
//  Rocket
//
//  Created by Wellington Pardim Ferreira on 5/27/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import CoreData
import UIKit

class Manager:NSObject {
    
    static let sharedInstance = Manager()
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    
    
    override init() {
        
    }
    
    //it checks whether the stage was accomplished or not.
//    func getLevelBool(level:String)-> Bool{
//        
//        let entityDescription =
//        NSEntityDescription.entityForName("Levels",
//            inManagedObjectContext: self.managedObjectContext!)
//        
//        let request = NSFetchRequest()
//        request.entity = entityDescription
//        
//        
//        var error: NSError?
//        
//        var objects = managedObjectContext?.executeFetchRequest(request,
//            error: &error)
//        
//        if let results = objects {
//            
//            if results.count > 0 {
//                let match = results[0] as! NSManagedObject
//                
//                var a: AnyObject =      match.valueForKey(level)!
//                
//                if(a as! NSObject  == 1){
//                    return true
//                }else{
//                    return false
//                }
//                
//                
//            }
//            
//        }
//        return false
//    }
//    
    func getLevelStatus(stage:String) -> Bool {
        let entityDescription = NSEntityDescription.entityForName("Levels", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        var error: NSError?
        
        var objects: [AnyObject]?
        do {
            objects = try managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            objects = nil
        }
        
        if let results = objects {
            if results.count > 0 {
                for result in results {
                    let match = result as! NSManagedObject
                    
                    let stageName: AnyObject = match.valueForKey("stageName")!
                    let levelStatus: AnyObject = match.valueForKey("status")!
                    
                    if stageName as! String == stage && levelStatus as! NSObject == 1 {
                        return true
                    }
                    else {
                        return false
                    }
                }
            }
        }
        else {
                return false
            }
        return false
        }
    
    func allLevelStatuses() ->[Bool] {
        var statusLevelArray = [Bool]()
        let entity = NSEntityDescription.entityForName("Levels", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "stageName", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        request.entity = entity
        
        var error: NSError?
        
        var objects: [AnyObject]?
        do {
            objects = try managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            objects = nil
        }
        
        if let results = objects {
            for result in results {
                let match = result as! NSManagedObject
                statusLevelArray.append(match.valueForKey("status") as! Bool)
                
                let stage: String = match.valueForKey("stageName") as! String
                let status : Bool = match.valueForKey("status") as! Bool
                print("stage: \(stage) ")
                print("status: \(status)")
                //lembrar que está desordenado
            
            }
            
        }
        print(statusLevelArray)
        return statusLevelArray
    }

    
//    func setLevelBool(level:String, boolLevel:Bool){ //muda o valor de algum level para true ou false
//        
//        
//        let entityDescription =
//        NSEntityDescription.entityForName("Levels",
//            inManagedObjectContext: self.managedObjectContext!)
//        
//        let request = NSFetchRequest()
//        request.entity = entityDescription
//        
//        
//        var error: NSError?
//        
//        var objects = managedObjectContext?.executeFetchRequest(request,
//            error: &error)
//        
//        if let results = objects {
//            
//            if results.count > 0 {
//                let match = results[0] as! NSManagedObject
//                
//                match.setValue(boolLevel, forKey: level)
//                managedObjectContext?.save(&error)
//                
//                
//            }
//            
//        }
//    }
    
    func updateLevelStatus(stage: String, newStatus: Bool) {
        let entityDescription = NSEntityDescription.entityForName("Levels", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        
        var objects: [AnyObject]?
        do {
            objects = try managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            objects = nil
        }
        
        if let results = objects {
            if results.count <= 0 {
                print("Não há dados a serem atualizados!")
            }
            else {
                for result in results {
                    let match = result as! NSManagedObject
                    print(match)
                    let stageName: AnyObject? = match.valueForKey("stageName")
                    let status: AnyObject? = match.valueForKey("status")
                    print("\(stageName as! String)")
                    print("\(status as! Bool)")
                    
                    if stage == stageName as! String {
                        match.setValue(newStatus, forKey: "status")
                        do {
                            try managedObjectContext?.save()
                        } catch let error1 as NSError {
                            error = error1
                        }
                    }
                    
                }
            }
        }
    }
    
    func dataBaseChecker() {
        let entityDescription = NSEntityDescription.entityForName("Levels", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        
        var objects: [AnyObject]?
        do {
            objects = try managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            objects = nil
        }
        
        if let results = objects {
            if results.count == 0 {
                print("Cadastrando...")
                for index in 0 ... 2 {
                    let newLevel = Levels(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                    newLevel.stageName = "stage\(index+1)"
                    newLevel.status = false
                    print("stage \(index + 1) inserido!")
                }
                do {
                    try managedObjectContext?.save()
                } catch let error1 as NSError {
                    error = error1
                }
            }
            else {
              print("Fases já carregadas!")
            }
        }
    }

    
//    func checkDataBase(){ //checa se existe algum registro no banco, caso nao houver, ele cria um novo
//        
//        let entityDescription =
//        NSEntityDescription.entityForName("Levels",
//            inManagedObjectContext: self.managedObjectContext!)
//        
//        let request = NSFetchRequest()
//        request.entity = entityDescription
//        
//        
//        var error: NSError?
//        
//        var objects = managedObjectContext?.executeFetchRequest(request,
//            error: &error)
//        
//        if let results = objects {
//            
//            if results.count == 0 {
//                
//                println("efetuando cadastro" )
//
//                
//                let lvl = Levels(entity: entityDescription!,
//                    insertIntoManagedObjectContext: managedObjectContext)
//                
//                lvl.level1 = false
//                lvl.level2 = false
//                lvl.level3 = false
//                lvl.level4 = false
//                lvl.level5 = false
//                lvl.level6 = false
//                
//                var error: NSError?
//                
//                managedObjectContext?.save(&error)
//                
//            }else{
//                println("cadastro já existe")
//                let match = results[0] as! NSManagedObject
//                
//                for index in 1...6{
//                    var foo: AnyObject? = match.valueForKey("level\(index)")
//                    println("level\(index) situação \(foo)")
//                }
//            }
//            
//            
//            
//        }
//    }
    
    
    
}




