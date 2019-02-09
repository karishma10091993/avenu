//
//  LoginViewController.h
//  SriBalajiSaiRam_Chit
//
//  Created by kireeti on 09/02/19.
//  Copyright © 2019 KireetiSoftSolutions. All rights reserved.

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface LoginViewController : ViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *txtFldUserName;
    IBOutlet UITextField *txtFldPwd;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UIImageView *imgCompanyLogo;
    IBOutlet UIImageView *profilelogoimg;
    IBOutlet UILabel *lblusrname;
    IBOutlet UILabel *lblpwd;
    IBOutlet UIButton *btnsbmt;
}
-(IBAction)submit_TouchUpInside:(UIButton*)sender;

@end
