//
//  MainViewController.swift
//  RecordPicker
//
//  Created by Tiago Valente on 29/10/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet var textFieldUsername: UITextField!
    @IBOutlet var buttonRandomRecord: UIButton!
    @IBOutlet var labelArtistName: UILabel!
    @IBOutlet var imageViewRecord: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldUsername.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let username = Helper.getUsername() {
            textFieldUsername.text = username
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NavigationController.shared().openPopUpView()
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        if let name = textFieldUsername.text, !name.isEmpty {

            Helper.saveUsername(name)
            self.labelArtistName.text = ""
            self.imageViewRecord.image = nil

            if let folders = Helper.getReleases() {
                self.callRequestRelease(numberReleases: folders)
            } else {
                Folders.requestFolder(success: { (response) in
                    
                    if let numberReleases = response.folders.first?.count {
                        Helper.saveReleases(numberReleases)
                        Releases.requestRelease(numberOfItems: numberReleases ,success: { (response) in
                            DispatchQueue.main.async {
                                self.labelArtistName.text = (response.releases.first?.basicInformation.artists.first?.name)! + " - " +
                                    (response.releases.first?.basicInformation.title)!
                                if let imageURL = URL(string: (response.releases.first?.basicInformation.coverImage)!) {
                                    self.imageViewRecord.load(url: imageURL)
                                }
                            }
                        }) { (error) in
                            print(error)
                        }
                    }
                    
                }, failure: { (error) in
                    print(error)
                })
            }
        }
    }
    
    func callRequestRelease(numberReleases : Int) {

        Releases.requestRelease(numberOfItems: numberReleases ,success: { (response) in
            DispatchQueue.main.async {
                self.labelArtistName.text = (response.releases.first?.basicInformation.artists.first?.name)! + " - " +
                    (response.releases.first?.basicInformation.title)!
                if let imageURL = URL(string: (response.releases.first?.basicInformation.coverImage)!) {
                    self.imageViewRecord.load(url: imageURL)
                }
            }
        }) { (error) in
            print(error)
        }
    }
}

extension MainViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
