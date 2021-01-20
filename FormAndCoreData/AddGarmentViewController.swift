//
//  AddGarmentViewController.swift
//  FormAndCoreData
//

//

import UIKit

protocol AddGarmentDelegate {
    func garmentAdded()
}

class AddGarmentViewController: UIViewController {

    @IBOutlet weak var garmentNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var garmentNameLabel: UILabel!
    var delegate : AddGarmentDelegate?
    var garmentViewModel : GarmentViewModel = GarmentViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.topItem?.title = NSLocalizedString("Add", comment: "")
        self.saveButton.title = NSLocalizedString("Save", comment: "")
        self.garmentNameLabel.text = NSLocalizedString("Garment name", comment: "")
        self.garmentNameTextField.placeholder = NSLocalizedString("Enter name", comment: "")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveGarment(_ sender: Any) {
        if let name  = garmentNameTextField.text{
            garmentViewModel.currentGarmentName = name
            if garmentViewModel.isGarmentNameValid(){
                garmentViewModel.addGarment()
                self.delegate?.garmentAdded()
                self.dismiss(animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController.init(title: "Error", message: garmentViewModel.errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
