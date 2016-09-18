//
//  BooksViewController.m
//  PhoneCallBack
//
//  Created by Smartios2012 on 15/7/29.
//  Copyright (c) 2015年 com.hjl. All rights reserved.
//

#import "BooksViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactInfoModel.h"
#import "BooksDetailViewController.h"
#import "BookTableViewCell.h"
#import "PhoneViewController.h"
#import "ChineseString.h"

@interface BooksViewController () <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate> {
    ABAddressBookRef addressBookRef;
    NSArray *contacts;
    NSArray *filteredContacts;
    BOOL isSearch;
}


@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property(nonatomic,strong)NSMutableArray *fullNameArr;


@end

@implementation BooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    contacts = [NSMutableArray array];
    filteredContacts = [NSMutableArray array];
    isSearch = NO;
    self.fullNameArr  = [NSMutableArray array];
    self.indexArray = [NSMutableArray array];
    self.letterResultArr = [NSMutableArray array];
    
    addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getContactsFromAddressBook];
            });
        } else { 
            // TODO: Show alert
        }
    });
}

- (void)getContactsFromAddressBook {
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (addressBook) {
        NSArray *allContacts = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *mutableContacts = [NSMutableArray arrayWithCapacity:allContacts.count];
        NSUInteger i = 0;
        for (i = 0; i < [allContacts count]; i++) {
            ContactInfoModel *model = [[ContactInfoModel alloc] init];
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            model.recordId = ABRecordGetRecordID(contactPerson);
            
            // Get first and last names
            NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            
            // Set Contact properties
            model.firstName = firstName;
            model.lastName = lastName;
            
            // Get mobile number
            ABMultiValueRef phonesRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty);
            model.phone = [self getMobilePhoneProperty:phonesRef];
            if(phonesRef) {
                CFRelease(phonesRef);
            }
          
            // Get image if it exists
            NSData  *imgData = (__bridge_transfer NSData *)ABPersonCopyImageData(contactPerson);
            model.image = [UIImage imageWithData:imgData];
            if (!model.image) {
            model.image = [UIImage imageNamed:@"icon-avatar-60x60"];
            }
            
            [mutableContacts addObject:model];
           
        }
 
        if(addressBook) {
            CFRelease(addressBook);
        }
         contacts = [NSArray arrayWithArray:mutableContacts];
     
    //添加
        
    for (ContactInfoModel *model in contacts) {
        NSLog(@"fullName  %@",model.fullName);
    [self.fullNameArr addObject:[model fullName]];
        
        }
    NSArray *fullArr = self.fullNameArr;
   
        NSLog(@"%@",fullArr);
    self.indexArray = [ChineseString IndexArray:fullArr];
//    self.letterResultArr = [ChineseString LetterSortArray:fullArr];
    NSLog(@"full  %@",fullArr);
        
//    NSLog(@"index   --- %@",self.indexArray);
//    NSLog(@"letter  ---- %@",self.letterResultArr);
        [self.contactTableView reloadData];
        
    } else {
      
        NSLog(@"Error");

    }
}

- (NSString *)getMobilePhoneProperty:(ABMultiValueRef)phonesRef {
    for (int i = 0; i < ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        if (currentPhoneLabel) {
            if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
            if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                 return (__bridge NSString *)currentPhoneValue;
             
            }
        }
        if(currentPhoneLabel) {
            CFRelease(currentPhoneLabel);
        }
        if(currentPhoneValue) {
            CFRelease(currentPhoneValue);
        }
     
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch) {
        return filteredContacts.count;
    } else {
        return contacts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ContactCell";
    BookTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    ContactInfoModel *model = nil;

    if (isSearch) {
        model = filteredContacts[indexPath.row];
    } else {
        model = contacts[indexPath.row];
    }
    cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",model.lastName?:@"",model.firstName?:@""];
    cell.phoneLabel.text = model.phone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    ContactInfoModel *model = nil;
    if (isSearch) {
        model = filteredContacts[indexPath.row];
    } else {
        model = contacts[indexPath.row];
        
    }
 
    if ([model.phone hasPrefix:@"+86"]) {
 
    model.phone = [model.phone  stringByReplacingOccurrencesOfString:@"+86" withString:@""];;
    model.phone = [model.phone  stringByReplacingOccurrencesOfString:@" " withString:@""];;
    }
    
    PhoneViewController *phoneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"phoneVC"];
    phoneVC.phone = [model.phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneVC.name = [NSString stringWithFormat:@"%@%@",model.lastName?:@"",model.firstName?:@""];
    
    [self.navigationController pushViewController:phoneVC animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    isSearch = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    PhoneViewController *phoneB = [self.storyboard instantiateViewControllerWithIdentifier:@"bookS"];
    [self.navigationController pushViewController:phoneB animated:YES];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    检索输入框里的数据 并实时刷新返回
    if ([searchBar.text isEqualToString:@""]) {
        filteredContacts = contacts;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.%@ contains[cd] %@ OR self.%@ contains[cd] %@", @"firstName", searchBar.text, @"lastName", searchBar.text];
        filteredContacts = [contacts filteredArrayUsingPredicate:predicate];
    }
    [self.contactTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    if ([searchBar.text isEqualToString:@""]) {
        filteredContacts = contacts;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.%@ contains[cd] %@ OR self.%@ contains[cd] %@", @"firstName", searchBar.text, @"lastName", searchBar.text];
        filteredContacts = [contacts filteredArrayUsingPredicate:predicate];
    }
    
    [self.contactTableView reloadData];
    
    
    isSearch = NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BooksDetailViewController *booksDetailVC = segue.destinationViewController;
    booksDetailVC.model = sender;
    
}
@end
