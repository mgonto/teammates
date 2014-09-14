//
//  AddPlayerGroupViewController.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import UIKit

protocol PlayerGroupSettingsDelegate {
    func onCancel(vc: PlayerGroupSettingsViewController)
    func onSave(vc: PlayerGroupSettingsViewController, name: String, hours: Int, minutes: Int, dayOfWeek: DayOfWeek)
    func onLoad(vc: PlayerGroupSettingsViewController)
}


class PlayerGroupSettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    class AddGroupDelegate : PlayerGroupSettingsDelegate {
        func onCancel(vc: PlayerGroupSettingsViewController) {
            vc.performSegueWithIdentifier("goToPlayerGroupList", sender: self)
        }
        
        func onSave(vc: PlayerGroupSettingsViewController, name: String, hours: Int, minutes: Int, dayOfWeek: DayOfWeek) {
            var group = PlayerGroup(name, hours, minutes, dayOfWeek)
            vc.playerGroupRepository.save(group, callback: { (errorOpt, groupOpt) -> () in
                if let error = errorOpt {
                    NSLog("There was an error creating a group \(error)")
                } else {
                    vc.performSegueWithIdentifier("goToPlayerGroupList", sender: self)
                }
                
            })
            
        }
        
        func onLoad(vc: PlayerGroupSettingsViewController) {
            return
        }
    }
    
    class EditGroupDelegate : PlayerGroupSettingsDelegate {
        
        var playerGroup : PlayerGroup
        
        init(playerGroup : PlayerGroup) {
            self.playerGroup = playerGroup
        }
        
        func onCancel(vc: PlayerGroupSettingsViewController) {
            vc.performSegueWithIdentifier("goToPlayerGroupDashboard", sender: self)
        }
        
        func onSave(vc: PlayerGroupSettingsViewController, name: String, hours: Int, minutes: Int, dayOfWeek: DayOfWeek) {
            vc.performSegueWithIdentifier("goToPlayerGroupDashboard", sender: self)
            return
        }
        
        func onLoad(vc: PlayerGroupSettingsViewController) {
            vc.nameTextField.text = playerGroup.name
            vc.dayOfWeekPickerView.selectRow(playerGroup.dayOfWeek.dayNumber, inComponent: 0, animated: false)
            
            vc.hourPickerView.setDate(DateHelper.getDateFor(playerGroup.hour, minutes: playerGroup.minutes), animated: false)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dayOfWeekPickerView: UIPickerView!
    @IBOutlet weak var hourPickerView: UIDatePicker!
    
    var delegate : PlayerGroupSettingsDelegate!
    let playerGroupRepository = Application.sharedInstance.playerGroupRepository
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayOfWeekPickerView.delegate = self
        self.dayOfWeekPickerView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        delegate.onLoad(self)
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
    
    
    @IBAction func createGroup(sender: AnyObject) {
        let ( hours, minutes ) = DateHelper.hourAndMinutesFrom(self.hourPickerView.date)
        let dayNumber = self.dayOfWeekPickerView.selectedRowInComponent(0)
        let dayOfWeek = DayOfWeek.fromNumber(dayNumber)
        
        delegate.onSave(self, name: self.nameTextField.text, hours: hours, minutes: minutes, dayOfWeek: dayOfWeek)
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




