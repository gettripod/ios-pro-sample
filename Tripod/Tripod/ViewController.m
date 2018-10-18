//
//  ViewController.m
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>
#define MIN(A,B) ((A) <= (B) ? (A) : (B))

@interface ViewController ()
{
    NSData *imgData;
    //SRScreenRecorder *src;
    AppDelegate *appDel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-ddTHH:mm:ss.zzzz"];

}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)crash:(id)sender
{
    crashReport = [[CrashRepotingVC alloc]init];
    crashReport = [self.storyboard instantiateViewControllerWithIdentifier:@"CrashReportVC"];
    
    [self.navigationController pushViewController:crashReport animated:YES];
}
-(IBAction)shakeToreport:(id)sender
{
    shakeToReport = [[ShaketoReportVC alloc]init];
    shakeToReport = [self.storyboard instantiateViewControllerWithIdentifier:@"ShaketoCaptureVC"];
    [self.navigationController pushViewController:shakeToReport animated:YES];
    
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shakeNotification)
                                                 name:@"shake"
                                               object:nil];
    
}

-(void)shakeNotification :(NSNotification *)anote
{
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* Imagename = [documentsDirectory stringByAppendingPathComponent:@"test.png" ];
    
    
    if (!imgData)
    {
        imgData = UIImagePNGRepresentation(image);
        [imgData writeToFile:Imagename atomically:YES];
        tri = [[TripodViewController alloc]initWithNibName:@"TripodViewController" bundle:[NSBundle bundleWithIdentifier:@"com.gendevs.TripodFrame"]];
        
        if(![tri.view isDescendantOfView:self.view]) {
            [self.view addSubview:tri.view];
            [tri.editImageView setImage:image];
            
        } else {
            [tri.view removeFromSuperview];
            [tri.editImageView setImage:image];
        }
    }
}


@end
