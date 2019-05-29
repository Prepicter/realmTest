//
//  ViewController.swift
//  realmTest
//
//  Created by dit03 on 2019. 5. 29..
//  Copyright © 2019년 201835867. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}


class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(NSHomeDirectory())
        
    }
    
    @IBAction func saveValue(_ sender: Any) {
        let person = Person()
        
        person.name = nameLabel.text!
        person.age = Int(ageLabel.text!)!
        
        // DB 저장
        let realm = try! Realm()
        try! realm.write {
            realm.add(person)
        }
        nameLabel.text = ""
        ageLabel.text = ""
        
    }
    
    @IBAction func deleteValue(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        resultTextView.text = ""
    }
    
    
    @IBAction func getValue(_ sender: Any) {
        // DB 가져오기
        resultTextView.text = ""
        
        let realm = try! Realm()
        let vals = realm.objects(Person.self)
        
        if vals.count == 0 {
            resultTextView.text = "데이터 없음"
        } else {
            for i in vals {
                resultTextView.text = resultTextView.text! + "Name: \(i.name), Age: \(i.age)\n"
            }
        }
        
    }
    

}

