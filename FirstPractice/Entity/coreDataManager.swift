//
//  coreDataManager.swift
//  FirstPractice
//
//  Created by Miguel Eduardo  Valdez Tellez  on 17/08/20.
//  Copyright © 2020 Miguel Eduardo  Valdez Tellez . All rights reserved.
//

import Foundation
import CoreData

class coreDataManager{
    static let shared = coreDataManager()
    private let container : NSPersistentContainer!
    init()
    {
        container = NSPersistentContainer(name: "Model")
        setupDatabase()
    }
    
    private func setupDatabase() {
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) -\(error)")
                return
            }
            print("conexion exitosa")
        }
    }
    
    func createUsers(usuario: String, contraseña: String,flag: Bool, completion: @escaping() -> Void)
    {
        let context = container.viewContext
        let user = Users(context: context)
        user.user = usuario
        user.password = contraseña
        user.flagFaceId = flag
        //save
        do{
            try context.save()
            print("Usuario \(usuario) guardado")
            completion()
        }catch{
            print("Error guardando Usuario \(usuario)")
        }
    }
    
    
    func login(usuario: String, contraseña: String) -> Bool
    {
        var flag = false
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        do{
            let result = try container.viewContext.fetch(fetchRequest)
            result.forEach { (users) in
                if usuario == users.user && contraseña==users.password
                {
                    print("coinciden")
                    flag = true
                }
            }
        }catch{
            print("No existe usuario")
        }
        return flag
    }
    
    
    func usuarioExiste(usuario: String)->Bool{
        var flag = false
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        do{
            let result = try container.viewContext.fetch(fetchRequest)
            result.forEach { (users) in
                if usuario == users.user
                {
                    print("Usuario Existe")
                    flag = true
                }
            }
        }catch{
            print("No existe usuario")
        }
        return flag
    }
    
    func updateFlag(user: String, flagFaceId: Bool)
    {
        let fetchRequest : NSFetchRequest<Users> = Users.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            result.forEach { (users) in
                if user == users.user
                {
                    users.flagFaceId = flagFaceId
                }
            }
            try container.viewContext.save()
        }
        catch
        {
            print("El error obteniendo usuario \(error)")
        }
    }
    
}




