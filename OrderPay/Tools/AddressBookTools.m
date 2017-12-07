//
//  AddressBookTools.m
//  LoanInternalPlus
//
//  Created by mcitosh on 2017/6/15.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "AddressBookTools.h"
#import <AddressBookUI/AddressBookUI.h>
#import "JYAddressBookModel.h"
#import "CMRequestEngine+HttpTools.h"


@interface AddressBookTools()

@property (nonatomic) ABAddressBookRef addressBook;



@end

@implementation AddressBookTools

+ (AddressBookTools*) sharedInstance
{
    static AddressBookTools *_singleton = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}


///获取通讯录列表
+ (NSMutableArray *)getAddressBook
{
    NSMutableArray *addressBooks = [NSMutableArray array];
    // 1.获取授权状态
    //创建通讯录
    ABAddressBookRef addressBookAll = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    // 2.如果是已经授权,才能获取联系人
    if (status != kABAuthorizationStatusAuthorized) {
        //请求授权
        ABAddressBookRequestAccessWithCompletion(addressBookAll, ^(bool granted, CFErrorRef error) {

        });
    }
    if (status != kABAuthorizationStatusAuthorized) {return nil;}
    // 3.创建通信录对象
    //    ABAddressBookRef addressBook = ABAddressBookCreate();
    // 4.获取所有的联系人
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBookAll);
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    // 5.遍历所有的联系人
    for (int i = 0; i < peopleCount; i++) {
        JYAddressBookModel *bookModel = [[JYAddressBookModel alloc] init];
        // 5.1.获取某一个联系人
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        // 5.2.获取联系人的姓名
        NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef allName = ABRecordCopyCompositeName(person);
        NSString *fullName;
        if ((__bridge id)allName != nil)
        {
            fullName = (__bridge NSString *)allName;
        }
        else
        {
            if ((firstName != nil) || (lastName != nil)){
                fullName = [NSString stringWithFormat:@"%@ %@", firstName,lastName];
            }
        }
        bookModel.name = fullName;
        // 5.3.获取电话号码
        // 5.3.1.获取所有的电话号码
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        // 5.3.2.遍历拿到每一个电话号码
        for (int i = 0; i < phoneCount; i++) {
            // 1.获取电话对应的key
            //            NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
            // 2.获取电话号码
            NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            switch (i) {
                case 0:
                {
                    bookModel.telephone1 = phoneValue;
                }
                    break;
                case 1:
                {
                    bookModel.telephone2 = phoneValue;
                }
                    break;
                case 2:
                {
                    bookModel.telephone3 = phoneValue;
                }
                    break;
                default:
                    break;
            }
        }
        [addressBooks addObject:bookModel];
        CFRelease(phones);
    }
    CFRelease(addressBookAll);
    CFRelease(peopleArray);
    return addressBooks;
}
- (ABAddressBookRef)addressBook{
    if (!_addressBook) {
        _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
    return _addressBook;
}

//获取通讯录授权
+ (void)addressBookRequestAccess{
    ABAddressBookRef addressBookAll = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status != kABAuthorizationStatusAuthorized) {
        //请求授权
        ABAddressBookRequestAccessWithCompletion(addressBookAll, ^(bool granted, CFErrorRef error) {
            //保存通讯录
            NSArray *bookArr = AddressBookTools.getAddressBook;
            NSLog(@"%@", bookArr);
            if (bookArr.count > 0) {
                //保存
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVECONTANCT" object:nil];
                
            
            }
//            if let booksArr:NSMutableArray = AddressBookTools.getAddressBook(){
//                if booksArr.count > 0{
//                    JYContactManager.saveContanctInfo(booksArr)
//                }
//            }
        });
    }
}
@end
