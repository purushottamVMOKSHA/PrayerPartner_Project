//
//  SignUpViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "SignUpViewController.h"
#import "iToast.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "Constant.h"
#import "Postman.h"
@interface SignUpViewController ()
{
UIControl *activeField;
    Postman *postman;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *signupFacebookButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
   // self.signupFacebookButton.enabled = NO;
    postman =[[Postman alloc]init];
    [self placeholder];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)placeholder
{

//    [self.emailTextField setValue:[UIFont fontWithName: @"Helvetica Neue Bold" size: 15] forKeyPath:@"_placeholderLabel.font"];
//    [self.emailTextField setValue:[UIFont fontWithName: @"Helvetica Neue Bold" size: 15] forKeyPath:@"_placeholderLabel.font"];
//    [self.emailTextField setValue:[UIFont fontWithName: @"Helvetica Neue Bold" size: 15] forKeyPath:@"_placeholderLabel.font"];
    
    [self.emailTextField setValue:[UIColor grayColor]
                       forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordtextField setValue:[UIColor grayColor]
                          forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.nameTextField setValue:[UIColor grayColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
        }




- (IBAction)dismisskeypadMethod:(id)sender {
    
    [self.view endEditing:YES];
}

    -(void)viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];
        [self registerForKeyboardNotifications];
        self.emailTextField.text = @"";
        self.passwordtextField.text = @"";
        self.nameTextField.text =@"";

    
    }
    
    - (void)registerForKeyboardNotifications
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];
    }
    - (void)keyboardWasShown:(NSNotification*)aNotification
    {
        NSDictionary* info = [aNotification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        CGRect aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
            [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
        }
    }
    - (void)keyboardWillBeHidden:(NSNotification*)aNotification
    {
        UIEdgeInsets contentInsets=UIEdgeInsetsZero;
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    }
    - (void)textFieldDidBeginEditing:(UITextField *)textField
    {
        activeField = textField;
    }
    
    - (void)textFieldDidEndEditing:(UITextField *)textField
    {
        activeField = nil;
    }
    







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signupButtonAction:(id)sender {
 [self.view endEditing:YES];
    if (![self validateEntries])
    {
        return;
    }
    
//[self performSegueWithIdentifier:@"signuptothanku" sender:self];

   // [self callApiForSignup];

    [self mbProgress:@"Currently can't signup"];

}

- (IBAction)signupFacebookButton:(id)sender {

 [self mbProgress:@"Currently can't access"];
    
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    [login
//     logInWithReadPermissions: @[@"public_profile"]
//     fromViewController:self
//     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//         if (error) {
//             NSLog(@"Process error");
//         } else if (result.isCancelled) {
//             NSLog(@"Cancelled");
//         } else {
//             NSLog(@"Logged in");
//             [self loginpressfacebookButtonForDetails];
//         }
//     }];
}

-(void)loginpressfacebookButtonForDetails
{
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields": @"id,name,email,gender,hometown,languages,location"}]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"fetched user:%@", result);
//                 [self performSegueWithIdentifier:@"signuptothanku" sender:self];
//             }
//         }];
//    }
//    
    
}



-(void)callApiForSignup
{
    NSString *urlString =[NSString stringWithFormat:@"%@%@",pBaseUrl,pCategory];
    NSString *parameter =[NSString stringWithFormat:@"{\"request\":{\"firstName\":\"user\",\"lastName\":\"user\",\"email\":\"user@vmokshagroup.com\",\"password\":\"Power@123\",\"status\":true}}"];
    [postman post:urlString withParameter:parameter success:^(NSURLSessionDataTask *operation, id responseObject) {
      NSLog(@"Success");
        NSDictionary *responseDict =[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        [self parsingResponseForSignup:responseDict];
  } failour:^(NSURLSessionDataTask *operation, NSError *error) {
      NSLog(@"failour");
  }];
 
}
-(void)parsingResponseForSignup:(NSDictionary *)responseDict
{
    NSLog(@"%@",responseDict);

    
   // [self performSegueWithIdentifier:@"signuptothanku" sender:self];
    
}




- (BOOL)validateEntries
{
    BOOL goodToGo = YES;
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    if (self.nameTextField.text.length == 0)
    {
        goodToGo = NO;
        [mutableString appendString:@"Name is required"];
    }
    if (self.emailTextField.text.length == 0) {
        goodToGo = NO;
        
        if (mutableString.length > 0) {
            [mutableString appendString:@"\nEmail Id is required"];
        } else {
            [mutableString appendString:@"Email Id is required"];
        }
        
    }else if (![self stringIsValidEmail:self.emailTextField.text]&&self.emailTextField.text.length!=0)
    {
        goodToGo = NO;
        if (mutableString.length > 0) {
            [mutableString appendString:@"\nPlease enter a valid Email Id"];
        } else {
            [mutableString appendString:@"Please enter a valid Email Id"];
        }
    }
    if (self.passwordtextField.text.length == 0) {
        goodToGo = NO;
        if (mutableString.length > 0) {
            [mutableString appendString:@"\nPassword is required"];
        } else {
            [mutableString appendString:@"Password is required"];
        }

    }
    if (!goodToGo)
    {
    [self mbProgress:mutableString];
    }
    return goodToGo;
}


-(BOOL)stringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)mbProgress:(NSString*)message{
    MBProgressHUD *hubHUD=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hubHUD.mode=MBProgressHUDModeText;
    hubHUD.detailsLabelText=message;
    hubHUD.detailsLabelFont=[UIFont systemFontOfSize:15];
    hubHUD.margin=20.f;
    hubHUD.yOffset=150.f;
    hubHUD.removeFromSuperViewOnHide = YES;
    [hubHUD hide:YES afterDelay:2];
    
}


@end
