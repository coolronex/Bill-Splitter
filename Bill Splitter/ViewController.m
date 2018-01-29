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
@property (weak, nonatomic) IBOutlet UITextField *tipTextField;
@property (weak, nonatomic) IBOutlet UISlider *numberOfPerson;
@property (weak, nonatomic) IBOutlet UILabel *amountForEachPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderCurrentValueLabel;

@property (nonatomic, strong) NSDecimalNumber *totalBillAmount;
@property (nonatomic, strong) NSDecimalNumber *totalTipAmount;
@property (nonatomic, strong) NSDecimalNumber *totalBillWithTip;
@property (nonatomic, strong) NSDecimalNumber *tipPercentage;
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
    NSLog(@"Bill amount: $%@", self.totalBillAmount);
    self.tipPercentage = [[NSDecimalNumber alloc] initWithString:self.tipTextField.text];
    NSLog(@"Tip: %@%%", self.tipPercentage);
    
    
    
    //handler for NSDecimal dividing method
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                             scale:2
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    //calculations
    NSDecimalNumber *tip = [self.tipPercentage decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    NSDecimalNumber *totalBillWithTip = [self.totalBillAmount decimalNumberByAdding: tip]; //adding bill with tip
    NSDecimalNumber *eachPersonTotal = [totalBillWithTip decimalNumberByDividingBy:self.sliderValue withBehavior:handler]; //divide equally among everyone
    NSLog(@"Tip: %@", tip);
    NSLog(@"Bill + tip: $%@", totalBillWithTip);
    NSLog(@"Number of person: %@", self.sliderValue);
    NSLog(@"Total after calculations: $%@", eachPersonTotal);

    self.amountForEachPersonLabel.text = [NSString stringWithFormat:@"Total for each person is: $%@", eachPersonTotal];
}


- (IBAction)sliderMoved:(UISlider *)sender {
    
    //self.numberOfPerson.value has value in float that i want to convert to NSDecimalNumber
    //convert the current slider value to NSNumber (idk how to convert directly from float to NSDecimal number)
    NSNumber *currentSliderValue = [[NSDecimalNumber alloc] initWithInteger: self.numberOfPerson.value];

    //converting currentSliderValue into NSDecimal to be used for calculations
    NSDecimalNumber *convertedCurrentSliderValue = [NSDecimalNumber decimalNumberWithDecimal:currentSliderValue.decimalValue];
    self.sliderValue = convertedCurrentSliderValue;
    
    //label will self update because live continous events of slider is set ON through Interface Builder
    self.sliderCurrentValueLabel.text = [NSString stringWithFormat:@"Number of person: %@", self.sliderValue];
    
}




@end
