//
//  ShaketoReportVC.m
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "ShaketoReportVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AppDelegate.h"
@interface ShaketoReportVC ()
{
    NSData *imgData;
    AppDelegate *appDel;
    
}
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@end

@implementation ShaketoReportVC

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidLoad

{
    
    [CommonMethod updateNavigationbarInController:@"Shake TO Report" navigation:self.navigationItem];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbutton"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [super viewDidLoad];
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if(event.type == UIEventTypeMotion && event.subtype== UIEventSubtypeMotionShake)
    [self showActionSheet];
    
    
}

- (void)showActionSheet {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Tripod" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"LEAP" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Video Report" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Screen Report" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        [self shakeNotification:@"UIEventSubtypeMotionShakeEnded"];
        
    }]];
    [self dismissViewControllerAnimated:YES completion:^{
        }];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
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
             tri = [[TripodViewController alloc]initWithNibName:@"TripodViewController" bundle:[NSBundle bundleWithIdentifier:@"com.gendevs.TripodFramework"]];
            
            if(![tri.view isDescendantOfView:self.view]) {
                [self.view addSubview:tri.view];
                [tri.editImageView setImage:image];
                NSString * str = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
                
            } else {
                [tri.view removeFromSuperview];
                [tri.editImageView setImage:image];
            }
            
        }
}



-(void)goBack
{
     [self.navigationController popViewControllerAnimated:YES];
}

@end
