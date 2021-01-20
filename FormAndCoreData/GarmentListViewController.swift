//
//  ViewController.swift
//  FormAndCoreData
//

//

import UIKit

class GarmentListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var garmentViewModel : GarmentViewModel = GarmentViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("List", comment: "")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        garmentViewModel.refreshData()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add"{
            let add = segue.destination as! AddGarmentViewController
            add.delegate = self
        }
    }
    
    @IBAction func sort(_ sender: UISegmentedControl) {
        garmentViewModel.selection = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        self.tableView.reloadData()
    }
    
}

extension GarmentListViewController : UITableViewDelegate,UITableViewDataSource,AddGarmentDelegate{
    
    func garmentAdded() {
        garmentViewModel.refreshData()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garmentViewModel.garments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let garment = garmentViewModel.garments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "garmentCell")
        cell?.textLabel?.text = garment.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.garmentViewModel.deleteGarments(offsets: IndexSet.init(integer: indexPath.row))
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
