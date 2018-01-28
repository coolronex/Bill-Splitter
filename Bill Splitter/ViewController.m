//
//  ViewController.m
//  Bill Splitter
//
//  Created by Aaron Chong on 1/28/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *totalBillTextField;
@property (weak, nonatomic) IBOutlet UISlider *numberOfPerson;
@property (weak, nonatomic) IBOutlet UILabel *amountForEachPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderCurrentValueLabel;

@property (nonatomic, strong) NSDecimalNumber *totalBillAmount;
@property (nonatomic, strong) NSDecimalNumber *sliderValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)calculateSplitAmount:(UIButton *)sender {

    //if user input in textfield has no value then it's auto set to 0
    if ([self.totalBillTextField.text isEqualToString:@""]) {
        
        self.totalBillTextField.text = [NSString stringWithFormat:@"0"];
    }
        
    //get string from textField and convert to NSDecimalNumber
    self.totalBillAmount = [[NSDecimalNumber alloc] initWithString:self.totalBillTextField.text];
    NSLog(@"Total: %@", self.totalBillAmount);
    
    //handler for NSDecimal dividing method
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                             scale:2
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    //calculations
    self.totalBillAmount = [self.totalBillAmount decimalNumberByDividingBy:self.sliderValue withBehavior:handler];

    NSLog(@"Total after calculations: %@", self.totalBillAmount);
    NSLog(@"Current value of slider: %@", self.sliderValue);
    
    self.amountForEachPersonLabel.text = [NSString stringWithFormat:@"Total for each person is: $%@", self.totalBillAmount];
}

- (IBAction)sliderMoved:(UISlider *)sender {
    
    //sender.value sends current value(float)
    //then i convert it to NSNumber (idk how to convert directly from float to NSDecimal number)
    NSNumber *currentSliderValue = [[NSDecimalNumber alloc] initWithInteger:sender.value];
    
    //converting currentSliderValue into NSDecimal to be used for calculations
    NSDecimalNumber *convertedCurrentSliderValue = [NSDecimalNumber decimalNumberWithDecimal:currentSliderValue.decimalValue];
    self.sliderValue = convertedCurrentSliderValue;
    
    //label will self update because live continous events of slider is set ON through Interface Builder
    self.sliderCurrentValueLabel.text = [NSString stringWithFormat:@"Number of person: %@", currentSliderValue];
}


@end
