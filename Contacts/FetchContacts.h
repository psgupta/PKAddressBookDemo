//
//  Contacts.h
//  PKAddressBookDemo
//
//  Created by Randem IT on 11/02/16.
//  Copyright © 2016 RIT_MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
@interface FetchContacts : NSObject{
    
    NSMutableArray *arrContacts;
}

- (void)requestPermissionForContactsAccessAndFetch;
- (NSArray *)fetchAllContacts;

@end
