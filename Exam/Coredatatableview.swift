//
//  Coredatatableview.swift
//  Exam
//
//  Created by Diego on 07/02/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Coredatatableview: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    //Usando CoreData
    var tasks = [NSManagedObject]()
    
    var ID: [String] = ["1","2","3","4"]
    var Nombre: [String] = ["Miguel Cervante","Juan Morale","Roberto Méndez","Miguel Cueva"]
    var Fechanac: [String] = ["8/Dic/1990","03/Jul/1990","14/Dic/1990","08/Dic/1990"]
    var posicionarray: [String] = ["Desarrollador","Diseñador","Desarrollador","Programador"]
    var aliasarray: [String] = ["preg1","preg2","preg3","preg4"]
    
    
    
    @IBAction func Agregar_Usuarios(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
        //PLACEHOLDER 1
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Introduce ID"
        }
        //PLACEHOLDER 2
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Introduce un Nombre"
        }
        //PLACEHOLDER 3
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Introduce una Fecha"
        }
        
        //PLACEHOLDER 4
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Introduce una Profesion"
        }
        
        //PLACEHOLDER 5
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Introduce una Tag"
        }
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            let thirdTextField = alertController.textFields![2] as UITextField
            let fourTextField = alertController.textFields![3] as UITextField
            let fiveTextField = alertController.textFields![4] as UITextField
            
            self.saveTask(nameTask: firstTextField.text!, nameTask2: secondTextField.text!, nameTask3: thirdTextField.text!, nameTask4: fourTextField.text!, nameTask5: fiveTextField.text!)
           self.tableview.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
       tableview.reloadData()
    viewWillAppear(true)
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:tablecell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! tablecell
        
//
        let task = self.tasks[indexPath.row]
        //Con KVC obtenemos el contenido del atributo "name" de la task y lo añadimos a nuestra Cell
        cell.NOMBRE.text = task.value(forKey: "name") as? String
        cell.ALIAS.text = task.value(forKey: "nickname") as? String
        cell.FECNAC.text = task.value(forKey: "fecha") as? String
        cell.POSICIO.text = task.value(forKey: "puesto") as? String

        return cell
        
        
//        let id1 = self.ID[indexPath.row]
//        let nombre1 = self.Nombre[indexPath.row]
//        let fechanac1 = self.Fechanac[indexPath.row]
//        let pos1 = self.posicionarray[indexPath.row]
//        let alias1 = self.aliasarray[indexPath.row]
//
//        cell.ID.text = id1
//        cell.NOMBRE.text = nombre1
//        cell.FECNAC.text = fechanac1
//        cell.POSICIO.text = pos1
//        cell.ALIAS.text = alias1
//
//        return cell
    }
    
    //guarda datos
    func saveTask(nameTask:String,nameTask2:String,nameTask3:String,nameTask4:String,nameTask5:String){
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedContext)
        let task = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        //3
        task.setValue(nameTask, forKey: "name")
        task.setValue(nameTask2, forKey: "id")
        task.setValue(nameTask3, forKey: "fecha")
        task.setValue(nameTask4, forKey: "nickname")
        task.setValue(nameTask5, forKey: "puesto")
        
        //4
        do {
            try managedContext.save()
            //5
            tasks.append(task)
        } catch let error as NSError {
            print("No ha sido posible guardar \(error), \(error.userInfo)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest : NSFetchRequest<Entity> = Entity.fetchRequest()
        
        // 3
        do {
            let results = try managedContext.fetch(fetchRequest)
            tasks = results as [NSManagedObject]
        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
        // 4
        tableview.reloadData()
    }
}
