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
    
    func getLevelBool(level:String)-> Bool{
        
        let entityDescription =
        NSEntityDescription.entityForName("Levels",
            inManagedObjectContext: self.managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                var a: AnyObject =      match.valueForKey(level)!
                
                if(a as! NSObject  == 1){
                    return true
                }else{
                    return false
                }
                
                
            }
            
        }
        return false
    }
    
    func setLevelBool(level:String, boolLevel:Bool){ //muda o valor de algum level para true ou false
        
        
        let entityDescription =
        NSEntityDescription.entityForName("Levels",
            inManagedObjectContext: self.managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                match.setValue(boolLevel, forKey: level)
                managedObjectContext?.save(&error)
                
                
            }
            
        }
    }
    
    func checkDataBase(){ //checa se existe algum registro no banco, caso nao houver, ele cria um novo
        
        let entityDescription =
        NSEntityDescription.entityForName("Levels",
            inManagedObjectContext: self.managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count == 0 {
                
                println("efetuando cadastro" )

                
                let lvl = Levels(entity: entityDescription!,
                    insertIntoManagedObjectContext: managedObjectContext)
                
                lvl.level1 = false
                lvl.level2 = false
                lvl.level3 = false
                lvl.level4 = false
                lvl.level5 = false
                lvl.level6 = false
                
                var error: NSError?
                
                managedObjectContext?.save(&error)
                
            }else{
                println("cadastro já existe")
                let match = results[0] as! NSManagedObject
                
                for index in 1...6{
                    var foo: AnyObject? = match.valueForKey("level\(index)")
                    println("level\(index) situação \(foo)")
                }
            }
            
            
            
        }
    }
    
    
    
}




