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
            
           
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:tablecell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! tablecell
        
        let id1 = self.ID[indexPath.row]
        let nombre1 = self.Nombre[indexPath.row]
        let fechanac1 = self.Fechanac[indexPath.row]
        let pos1 = self.posicionarray[indexPath.row]
        let alias1 = self.aliasarray[indexPath.row]
        
        cell.ID.text = id1
        cell.NOMBRE.text = nombre1
        cell.FECNAC.text = fechanac1
        cell.POSICIO.text = pos1
        cell.ALIAS.text = alias1
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
