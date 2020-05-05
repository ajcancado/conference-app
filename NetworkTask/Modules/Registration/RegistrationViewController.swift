
import UIKit

class RegistrationViewController: UIViewController {
    
    var viewModel: RegistrationViewModel = RegistrationViewModel()

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindables()
    }
    
    private func setupBindables() {
        viewModel.goToEventsViewController.bind { value in
            self.goToEventsViewController()
        }
    }

    @IBAction func loginAction(_ sender: Any) {
        viewModel.registerUserWith(login: userNameTextField.text, password: passwordTextField.text)
    }
    
    private func goToEventsViewController() {
        let svc = EventsViewController.instantiate(fromAppStoryboard: AppStoryboard.main)
        let navController = UINavigationController(rootViewController: svc)
        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true)
    }
}
