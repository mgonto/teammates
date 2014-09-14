//
//  AddPlayerGroupViewController.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import UIKit

class PlayerGroupSettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dayOfWeekPickerView: UIPickerView!
    @IBOutlet weak var hourPickerView: UIDatePicker!
    
    var playerGroup : PlayerGroup?
    let playerGroupRepository = Application.sharedInstance.playerGroupRepository
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayOfWeekPickerView.delegate = self
        self.dayOfWeekPickerView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        setFieldInitialValues()
    }

    func setFieldInitialValues() {
        if let group = playerGroup {
            nameTextField.text = group.name
            dayOfWeekPickerView.selectRow(group.dayOfWeek.dayNumber, inComponent: 0, animated: false)
            
            hourPickerView.setDate(DateHelper.getDateFor(group.hour, minutes: group.minutes), animated: false)
        }
        
    }
    
    func setInEditMode(playerGroup : PlayerGroup) {
        NSLog("Estoy en edit mode")
        self.playerGroup = playerGroup
    }
    
    @IBAction func enterPressOnNameTextField(sender: AnyObject) {
        self.nameTextField.resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }

    // MARK: - UIPickerViewDelegate methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return DayOfWeek.fromNumber(row).description
    }
    
    @IBAction func onTapOnScreen(sender: AnyObject) {
        self.nameTextField.resignFirstResponder()
    }
    
    func isInEditMode() -> Bool {
        if let group = playerGroup {
            NSLog("ES TRUE")
            return true
        } else {
            NSLog("ES FALSE")
            return false
        }
    }
    
    @IBAction func goBack(sender: AnyObject) {
        if (self.isInEditMode()) {
            self.performSegueWithIdentifier("goToPlayerGroupDashboard", sender: self)
        } else {
            self.performSegueWithIdentifier("goToPlayerGroupList", sender: self)
        }
    }
    
    
    @IBAction func createGroup(sender: AnyObject) {
        let ( hours, minutes ) = DateHelper.hourAndMinutesFrom(self.hourPickerView.date)
        let dayNumber = self.dayOfWeekPickerView.selectedRowInComponent(0)
        let dayOfWeek = DayOfWeek.fromNumber(dayNumber)
        
        if let group = playerGroup {
            playerGroup = nil // cancel edit mode

            self.performSegueWithIdentifier("goToPlayerGroupDashboard", sender: self)
        } else {
            var group = PlayerGroup(self.nameTextField.text, hours, minutes, dayOfWeek)
            playerGroupRepository.save(group, callback: { (errorOpt, groupOpt) -> () in
                if let error = errorOpt {
                    NSLog("There was an error creating a group \(error)")
                } else {
                    self.performSegueWithIdentifier("goToPlayerGroupList", sender: self)
                }
                
            })
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
