//
//  ViewController.swift
//  PriceCaculator
//
//  Created by Yunfeng Hu on 3/13/16.
//  Copyright © 2016 Yunfeng Hu. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}




class ViewController: UIViewController {
    
    // text
    @IBOutlet weak var originalPriceText: UITextField!
    @IBOutlet weak var discountText: UITextField!
    @IBOutlet weak var taxText: UITextField!
    @IBOutlet weak var purchaseFeeText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var shippingFeeText: UITextField!
    @IBOutlet weak var shippingFeeTotalText: UITextField!
    @IBOutlet weak var exchangeRateText: UITextField!
    @IBOutlet weak var packagePriceText: UITextField!
    
    // label
    @IBOutlet weak var atpDollarLable: UILabel!
    @IBOutlet weak var qpDollarLable: UILabel!
    @IBOutlet weak var profitDollarLable: UILabel!
    //@IBOutlet weak var atpRMBLable: UILabel!
    @IBOutlet weak var qpRMBLable: UILabel!
    @IBOutlet weak var profitRMBLable: UILabel!
    @IBOutlet weak var InsuranceDollarLable: UILabel!
    @IBOutlet weak var InsuranceRMBLable: UILabel!
    
    @IBOutlet weak var messageLable: UILabel!
    
    // deal with keyboard when enter number
    @IBAction func CloseKeyBoard(_ sender: AnyObject) {
        originalPriceText.resignFirstResponder()
        discountText.resignFirstResponder()
        taxText.resignFirstResponder()
        purchaseFeeText.resignFirstResponder()
        weightText.resignFirstResponder()
        shippingFeeText.resignFirstResponder()
        shippingFeeTotalText.resignFirstResponder()
        exchangeRateText.resignFirstResponder()
        packagePriceText.resignFirstResponder()
    }

    @IBAction func keyBoardDone(_ sender: UITextField) {
        originalPriceText.resignFirstResponder()
        discountText.resignFirstResponder()
        taxText.resignFirstResponder()
        purchaseFeeText.resignFirstResponder()
        weightText.resignFirstResponder()
        shippingFeeText.resignFirstResponder()
        shippingFeeTotalText.resignFirstResponder()
        exchangeRateText.resignFirstResponder()
        packagePriceText.resignFirstResponder()
    }
    
    // calculate button
    @IBAction func calculateButton(_ sender: UIButton) {
        var originalPrice: Float!
        var discount: Float!
        var tax: Float!
        var purchaseFee: Float!
        var weight: Float!
        var unitShippingFee: Float!
        var ShippingFee: Float!
        var exchangeRate: Float!
        var PackagePrice: Float!
        
        var afterTaxPrice: Float!
        var InsuranceFeeDollar: Float!
        var InsuranceFeeRMB: Float!
        var quotePriceDollar: Float!
        var profitDollar: Float!
        var quotePriceRMB: Float!
        var profitRMB: Float!
        
        if(Float(originalPriceText.text!)<=0){
            messageLable.text = "Enter Correct Price!"
            return
        }else if(Float(discountText.text!)<0 || Float(discountText.text!)>100){
            messageLable.text = "Enter Correct Discount!"
            return
        }else if(Float(taxText.text!)<0 || Float(taxText.text!)>100){
            messageLable.text = "Enter Correct Tax Rate!"
            return
        }else if(Float(purchaseFeeText.text!)<0 || Float(purchaseFeeText.text!)>100){
            messageLable.text = "Enter Correct Purchase Rate!"
            return
        }else if(Float(weightText.text!)==0){
            messageLable.text = "Enter Correct Weight!"
            return
        }else if(Float(shippingFeeText.text!)<0){
            messageLable.text = "Enter Correct Unit Shipping Fee ($/lb)!"
            return
        }else if(Float(exchangeRateText.text!)<=0){
            messageLable.text = "Enter Correct Exchange Rate!"
            return
        }else if(Float(packagePriceText.text!)<0){
            messageLable.text = "Enter Correct Package price!"
            return
        }else{
            messageLable.text = "Message: "
            originalPrice = Float(originalPriceText.text!)
        }
        
        //print("original price = \(originalPrice)")
        originalPrice   = Float(originalPriceText.text!)
        discount        = Float(discountText.text!)
        tax             = Float(taxText.text!)
        purchaseFee     = Float(purchaseFeeText.text!)
        weight          = Float(weightText.text!)
        unitShippingFee = Float(shippingFeeText.text!)
        exchangeRate    = Float(exchangeRateText.text!)
        PackagePrice    = Float(packagePriceText.text!)
        print("originalPrice=\(originalPrice), discout=\(discount), tax=\(tax), purchaseFee=\(purchaseFee), weithg=\(weight), unitShippingFee=\(unitShippingFee), exchangeRate=\(exchangeRateText), PackagePrice=\(PackagePrice)")
        
        afterTaxPrice   = (originalPrice*(100-discount)/100)*(1+tax/100)
        atpDollarLable.text = String(afterTaxPrice)
        
        InsuranceFeeDollar = afterTaxPrice*0.03
        InsuranceDollarLable.text = String(InsuranceFeeDollar)
        
        InsuranceFeeRMB = InsuranceFeeDollar * exchangeRate
        InsuranceRMBLable.text = String(InsuranceFeeRMB)
        
        profitDollar    = afterTaxPrice * purchaseFee/100
        profitDollarLable.text = String(profitDollar)
        
        profitRMB       = profitDollar*exchangeRate
        profitRMBLable.text = String(profitRMB)
        
        ShippingFee     = weight * unitShippingFee
        shippingFeeTotalText.text = String(ShippingFee)
        
        quotePriceDollar = afterTaxPrice*(1+purchaseFee/100) + ShippingFee + PackagePrice + InsuranceFeeDollar
        qpDollarLable.text = String(quotePriceDollar)
        
        quotePriceRMB   = quotePriceDollar * exchangeRate
        qpRMBLable.text = String(quotePriceRMB)
        
    }

    @IBAction func resetButton(_ sender: UIButton) {
        atpDollarLable.text = String(0.0)
        profitDollarLable.text = String(0.0)
        profitRMBLable.text = String(0.0)
        shippingFeeTotalText.text = String(0.0)
        qpDollarLable.text = String(0.0)
        qpRMBLable.text = String(0.0)
        InsuranceDollarLable.text = String(0.0)
        InsuranceRMBLable.text = String(0.0)
        
        originalPriceText.text = String(0.0)
    }
}
















