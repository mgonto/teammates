//
//  AddPlayerGroupViewController.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import UIKit

class AddPlayerGroupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dayOfWeekPickerView: UIPickerView!
    @IBOutlet weak var hourPickerView: UIDatePicker!
    
    let playerGroupRepository = Application.sharedInstance.playerGroupRepository
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayOfWeekPickerView.delegate = self
        self.dayOfWeekPickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let date = self.hourPickerView.date
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit, fromDate: date)
        let dayNumber = self.dayOfWeekPickerView.selectedRowInComponent(0)
        let dayOfWeek = DayOfWeek.fromNumber(dayNumber)
        let eventDate = EventDate(dayOfWeek, components.hour, components.minute)
        var group = PlayerGroup(self.nameTextField.text, eventDate, 10, nil)
        playerGroupRepository.save(group, callback: { (errorOpt, groupOpt) -> () in
            if let error = errorOpt {
                NSLog("There was an error creating a group \(error)")
            } else {
                self.performSegueWithIdentifier("goToPlayerGroupList", sender: self)
            }
            
        })
        
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
