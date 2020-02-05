//
//  ViewController.swift
//  HOL6
//
//  Created by Udayakumar Mathivanan on 2/4/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    //var inputName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createFolder(_ sender: UIButton) {
        
        var inputName:String = nameTextField.text!
        
        if inputName != ""
      {
        //create directory
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        
        let logsPath = documentsPath.appendingPathComponent(inputName)!
      
        print(logsPath)
        
        do{
        try FileManager.default.createDirectory(atPath: logsPath.path, withIntermediateDirectories: true, attributes: nil)
            
           
            
            showToastMessage(controller: self, message: "Folder created successfully", seconds: 5)
            
        }catch let error as NSError{
        print("Unable to create folder",error)
        }
    }else{
        showToastMessage(controller: self, message: "Enter the folder name", seconds: 5)
        }
        
    }
    
    @IBAction func showFiles(_ sender: UIButton) {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.path
        let fileManager = FileManager.default
        print(try! fileManager.contentsOfDirectory(atPath: filePath!))
        
    }
    
    @IBAction func writeFile(_ sender: UIButton) {
        
        let inputName:String? = nameTextField.text!
        
        let file = inputName!
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mi proin sed libero enim sed faucibus turpis"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        let fileURL = dir.appendingPathComponent(file)
        //writing
        do{
        try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }catch{
        print("unable to write file…")
        }
        }
    }
    
    @IBAction func readFile(_ sender: UIButton) {
        
        let inputName:String? = nameTextField.text!
              
        let file = inputName!
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
    
        let fileURL = dir.appendingPathComponent(file)
            
        do{
        let text = try String(contentsOf: fileURL, encoding: .utf8)
        print(text)
        }catch{
        print("unabe to read the file")
        }
        }
    }
    
    @IBAction func moveFile(_ sender: UIButton) {
        
        let inputName:String? = nameTextField.text!
                  
        let file = inputName!
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        let oldPath = dir.appendingPathComponent(file)
        let newPath = dir.appendingPathComponent("data/"+file)
        let fileManager = FileManager.default
        do{
        try fileManager.moveItem(at: oldPath, to: newPath)
        }catch{
        print("unable to move the file…")
        }
        }
    }
    
    @IBAction func copyFile(_ sender: UIButton) {
        
        let inputName:String? = nameTextField.text!
                         
       let file = inputName!
               
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        let originalFile = dir.appendingPathComponent(file)
        let copyFile = dir.appendingPathComponent("copy-"+file)
        let fileManager = FileManager.default
        do{
        try fileManager.copyItem(at: originalFile, to: copyFile)
        }catch{
        print("unable to copy the file")
        }
        }
        
    }
    
    
    @IBAction func filePermissions(_ sender: UIButton) {
        
        let inputName:String? = nameTextField.text!
                            
        let file = inputName!
                  
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(file){
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath){
        print("File Available")
        }else{
        print("File not available")
        }
        var filePermission:NSString = ""
        if (fileManager.isWritableFile(atPath: filePath)){
        filePermission = filePermission.appending("file is writable") as NSString
        }
        if(fileManager.isReadableFile(atPath: filePath)){
        filePermission = filePermission.appending(" file is readable") as NSString
        }
        if(fileManager.isExecutableFile(atPath: filePath)){
        filePermission = filePermission.appending(" file is executable") as NSString
        }
        print(filePermission)
        }
        
    }
    
    @IBAction func deleteFile(_ sender: UIButton) {
        
        let inputName:String? = nameTextField.text!
                                  
        let file = inputName!
                        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        let removeFile = dir.appendingPathComponent("copy-"+file)
        let fileManager = FileManager.default
        do{
        try fileManager.removeItem(at: removeFile)
        }catch{
        print("unable to remove file…")
        }
        }
        
    }
    
  /*  func getInputFromUser(controller : UIViewController,title : String) -> String?
    {
       
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler:{textField in textField.placeholder = "Enter the value"})
     //   alert.addAction(UIAlertAction(title:"Ok",style: .default,handler: { action in if let name = alert.textFields?.first?.text{ self.inputName = name}}))
        controller.present(alert,animated:true)
    
       // return self.inputName
    }*/
    //method to show the toast message
    func showToastMessage(controller : UIViewController, message : String , seconds : Double)
    
    {
        
        let alert = UIAlertController(title: nil,message: message,preferredStyle: .alert)
        //alert.view.backgroundColor = UIColor.black
       // alert.view.alpha = 0.6
        //alert.view.layer.cornerRadius = 25
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
        
    }
}

