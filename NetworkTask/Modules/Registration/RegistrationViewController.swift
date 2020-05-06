
import UIKit

class RegistrationViewController: UIViewController {
    
    var viewModel: RegistrationViewModel = RegistrationViewModel()
    var customLoading: CustomLoading = CustomLoading()

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }
    
    private func setupUI() {
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        descriptionLabel.text = viewModel.description
        registrationButton.layer.cornerRadius = 8
    }
    
    private func setupBindables() {
        
        viewModel.showActivityIndicator.bind { value in
            self.customLoading.showActivityIndicator(uiView: self.view)
        }
        
        viewModel.hideActivityIndicator.bind { value in
            self.customLoading.hideActivityIndicator(uiView: self.view)
        }
        
        viewModel.goToEventsViewController.bind { value in
            self.goToEventsViewController()
        }
        
        viewModel.showAlertController.bind { alertController in
           self.present(alertController, animated: true)
       }
    }

    @IBAction func loginAction(_ sender: Any) {
        viewModel.handleUserRegistration(login: userNameTextField.text, password: passwordTextField.text)
    }
    
    private func goToEventsViewController() {
        
        let svc = EventsViewController.instantiate(fromAppStoryboard: AppStoryboard.main)
        self.navigationController?.pushViewController(svc, animated: true)

    }
}
