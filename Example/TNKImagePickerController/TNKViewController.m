//
//  TNKViewController.m
//  TNKImagePickerController
//
//  Created by David Beck on 02/17/2015.
//  Copyright (c) 2014 David Beck. All rights reserved.
//

#import "TNKViewController.h"

#import <TNKImagePickerController/TNKImagePickerController.h>


@interface TNKViewController () <TNKImagePickerControllerDelegate>

@end

@implementation TNKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [self pickPhotos:nil];
    });
}


#pragma mark - Actions

- (IBAction)pickPhotos:(id)sender
{
    TNKImagePickerController *picker = [[TNKImagePickerController alloc] init];
    picker.mediaTypes = @[ (id)kUTTypeImage ];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:picker];
    navigationController.toolbarHidden = NO;
    navigationController.modalPresentationStyle = UIModalPresentationPopover;
    
    navigationController.popoverPresentationController.sourceView = self.pickPhotosButton;
    navigationController.popoverPresentationController.sourceRect = self.pickPhotosButton.bounds;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)pickSinglePhoto:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark - TNKImagePickerControllerDelegate

- (void)imagePickerController:(TNKImagePickerController *)picker
       didFinishPickingAssets:(NSOrderedSet *)assets {
    [[PHImageManager defaultManager] requestImagesForAssets:assets.array targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(NSDictionary *results, NSDictionary *infos) {
        NSArray *images = results.allValues;
        NSLog(@"images: %@", images);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(TNKImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
