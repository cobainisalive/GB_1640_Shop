//
//  UserDataViewController.swift
//  GB_1640_Shop
//
//  Created by Vitaliy Talalay on 13.04.2022.
//

import UIKit

class UserDataViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userAvatarImageView: AvatarImage!
    @IBOutlet weak var userNameTextView: UITextView!
    @IBOutlet weak var userBioTextView: StandartTextView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var editInfoButton: UIButton!
    @IBOutlet weak var emailTextView: SubTextView!
    @IBOutlet weak var genderTextView: SubTextView!
    @IBOutlet weak var saveEditedDataButton: UIButton!
    
    @IBAction func editUserData(_ sender: Any) {
        toggleEditInfo()
    }
    
    @IBAction func saveEditedData(_ sender: Any) {
        toggleEditInfo()
        viewModel.sendChageUserDataRequest(email: emailTextView.text ?? "")
    }
    
    private lazy var viewModel = UserDataViewModel()
    private lazy var keyboardHelper = KeyboardHelper()
    private let demoUser: User = User(id: 123,
                                      login: "Somebody",
                                      password: "Password",
                                      name: "Name",
                                      lastname: "Lastname",
                                      biography: "Bio bio bio bio bio bio bio bio bio",
                                      creditcard: "1234-1234-1234",
                                      email: "some@some.com",
                                      gender: "X")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardHelper.scrollView = scrollView
        keyboardHelper.hideKeyboardGesture()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardHelper.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardHelper.removeKeyboardObserver()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBlue
        userAvatarImageView.image = UIImage(named: "KyleBroflovski")
        setupLabelsView()
        setupTextViews()
        setupButtonsView()
    }
    
    private func setupButtonsView() {
        editInfoButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editInfoButton.setTitle("Редактировать", for: .normal)
        
        saveEditedDataButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        saveEditedDataButton.setTitle("Сохранить", for: .normal)
        saveEditedDataButton.isHidden = true
    }
    
    private func setupLabelsView() {
        emailLabel.text = "E-mail:"
        emailLabel.font = .systemFont(ofSize: FontSizes.standartLabel.rawValue, weight: .bold)
        
        genderLabel.text = "Gender:"
        genderLabel.font = .systemFont(ofSize: FontSizes.standartLabel.rawValue, weight: .bold)
    }
    
    private func setupTextViews() {
        userNameTextView.text = "\(demoUser.name) \(demoUser.lastname)"
        userNameTextView.textAlignment = .center
        userNameTextView.textColor = .systemBlue
        userNameTextView.font = .systemFont(ofSize: FontSizes.bigTextView.rawValue, weight: .bold)
        userNameTextView.isEditable = false
        userNameTextView.isScrollEnabled = false
        userNameTextView.isSelectable = true
        
        emailTextView.text = demoUser.email
        emailTextView.keyboardType = .emailAddress
        emailTextView.dataDetectorTypes = .link
        
        genderTextView.text = demoUser.gender
        
        userBioTextView.text = demoUser.biography
        userBioTextView.textAlignment = .center
        userBioTextView.textColor = .black
    }
    
    private func toggleEditInfo() {
        emailTextView.isEditable.toggle()
        genderTextView.isEditable.toggle()
        userBioTextView.isEditable.toggle()
        userNameTextView.isEditable.toggle()
        
        editInfoButton.isHidden.toggle()
        saveEditedDataButton.isHidden.toggle()
    }
}
