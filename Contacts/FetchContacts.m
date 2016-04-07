//
//  Contacts.m
//  PKAddressBookDemo
//
//  Created by Randem IT on 11/02/16.
//  Copyright © 2016 RIT_MacMini. All rights reserved.
//

#import "FetchContacts.h"
#import "Contact.h"
@implementation FetchContacts

- (void)requestPermissionForContactsAccessAndFetch
{
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    if (status != kABAuthorizationStatusAuthorized && status != kABAuthorizationStatusNotDetermined) {
        // tell user to enable contacts in privacy settings
        NSLog(@"You previously denied access: You must enable access to contacts in settings");
        
        return;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (!addressBook) {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        return;
    }
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (error) {
            NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
        }
        
        if (granted) {
            [self getContactsFromAddressBook:addressBook];
        } else {
            // tell user to enable contacts in privacy settings
            NSLog(@"You just denied access: You must enable access to contacts in settings");
        }
        
        CFRelease(addressBook);
    });
}

- (NSArray *)fetchAllContacts
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    NSArray *arrAllContacts = [self getContactsFromAddressBook:addressBook];
    
    if(addressBook){
        CFRelease(addressBook);
    }
    return arrAllContacts;
    
    
}


- (NSMutableArray*)getContactsFromAddressBook:(ABAddressBookRef)addressBook
{
    NSArray *allData = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    NSInteger contactCount = [allData count];
    
    if (contactCount>0) {
        
        arrContacts = [NSMutableArray array];
    }
    
    for (int i = 0; i < contactCount; i++) {
        
        ABRecordRef person = CFArrayGetValueAtIndex((__bridge CFArrayRef)allData, i);
        Contact *contactObj = [[Contact alloc] initWithABRecordRef:person];
        
        [arrContacts addObject:contactObj];
        
    }
    return arrContacts;
}
@end
