//
//  ContentView.swift
//  Lab#2
//
//  Created by Vincent on 9/20/22.
//

import SwiftUI

//class ZipCodeModel: ObservableObject {
//    var limit: Int = 5
//
//    @Published var zip: String = "" {
//        didSet {
//            if zip.count > limit {
//                zip = String(zip.prefix(limit))
//            }
//        }
//    }
//}
//class NumbersOnly: ObservableObject {
//    @Published var value = "" {
//        didSet {
//            let filtered = value.filter { $0.isNumber }
//
//            if value != filtered {
//                value = filtered
//            }
//        }
//    }
//}

struct ContentView: View {
    @State private var result_message: String=""
    
    @State private var companyName: String=""
    @State private var address: String=""
    @State private var city: String=""
    @State private var State: String=""
    @State private var Zip: String=""
    
    
//    @ObservedObject private var zipCodeModel = ZipCodeModel()
    
    
    @State private var Phone_Number: String=""
    @State private var Email_Address: String=""
    @State private var Mobile_phone: String=""
    @State private var Mobile_Carrier: String=""
    @State private var Username: String=""
    @State private var Password: String=""
    @State private var Re_Password: String=""
    
    @FocusState var isInputActive: Bool
//    @ObservedObject var input = NumbersOnly()
    
    var body: some View {
        Form{
            VStack{
                Text("New Customer Registration Form")
                    .foregroundColor(.cyan)
                    .font(.title3)
                    .bold()
                    .padding(.vertical, 5.0)
                    
                VStack{
                    VStack(alignment: .leading){
                        
                        Text("Company Information")
                            .font(.body)
                        TextField("Enter Company Name", text: $companyName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        TextField("Enter Address", text: $address)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .textInputAutocapitalization(.never)
                        TextField("Enter City", text: $city)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        TextField("Enter State - Abbreviation (2Chars,ie. NY, …)", text: $State)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        TextField("Enter Zip Code", text: $Zip)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                    }
                    
                    
                    VStack(alignment: .leading){

                        Text("User Information")
                            .font(.body)
                        TextField("Enter Phone Number", text: $Phone_Number)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                        TextField("Enter Email Address", text: $Email_Address)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        TextField("Enter Mobile phone", text: $Mobile_phone)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                        TextField("Enter Mobile Carrier", text: $Mobile_Carrier)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        TextField("Enter Username", text: $Username)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        SecureField("Enter your password", text: $Password)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        SecureField("Re-Enter Password", text: $Re_Password)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                    }
                    Group{
                        HStack{
                            VStack{
                                Button("SUBMIT"){
                                    
                                    Task{
                                        validateDataEntryForm()
                                    }
                                }
                                    .buttonStyle(.bordered)
                                    .controlSize(.regular)
                                Button("CLEAN  "){
                                    Task{
                                        clean()
                                    }
                                }
                                
                                    .buttonStyle(.bordered)
                                    .controlSize(.regular)
                            }
                            
                                
                            Text("Status:")
                                .font(.title3)
                                
                            ZStack{
                                Color.cyan
                                Text(result_message)
    //                                .font(.body)
    //                                .lineLimit(2)
    //                                .padding()
    //                                .background(Color.green)
                            }
                            .frame(height: 70.0)
                           
                            Spacer()
                        }
                       
                        
                            
                    }
                    
                } //end VStack
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .focused($isInputActive)
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {isInputActive = false}
                    }
                }

            }
        }
        

    } //end body
    
    
    func presentAlert(withTitle title:String, message :String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController,animated: true,completion: nil)
    }
    func clean(){
        result_message = ""
        companyName = ""
        address = ""
        city = ""
        State = ""
        Zip = ""
        Phone_Number = ""
        Email_Address = ""
        Mobile_phone = ""
        Mobile_Carrier = ""
        Username = ""
        Password = ""
        Re_Password = ""
        
    }

    
  

    
    
    func validateDataEntryForm(){
        let stateAbbreviations:[String] = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

        let companyNameTrimmed = companyName.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let addressTrimmed = address.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let cityTrimmed = city.trimmingCharacters(in: NSCharacterSet.whitespaces)
    

        var found2: Bool = false
        let MobileCarrier:[String] = ["Verizon", "AT&T", "T-Mobile"]
        
        //-----------------------------------
        //Check companyName
        //-----------------------------------
        if (companyNameTrimmed==""){
            presentAlert(withTitle: "Invalid Data Form", message: "Company name can not be blank!")
            return
        }
        if (companyNameTrimmed.count<5 || companyNameTrimmed.count>=100){
            presentAlert(withTitle: "Invalid Data Form", message: "Company name must be at least 5 characters in length and less than 100")
            return
        }
        //-----------------------------------
        //Check address
        //-----------------------------------
        if (addressTrimmed==""){
            presentAlert(withTitle: "Invalid Data Form", message: "Address can not be blank!")
            return
        }
        if (addressTrimmed.count<5 || addressTrimmed.count>=100){
            presentAlert(withTitle: "Invalid Data Form", message: "Address must be at least 5 characters in length and less than 100")
            return
        }
        //-----------------------------------
        //Check city
        //-----------------------------------
        if (cityTrimmed==""){
            presentAlert(withTitle: "Invalid Data Form", message: "City name can not be blank!")
            return
        }
        if (cityTrimmed.count<5 || addressTrimmed.count>=100){
            presentAlert(withTitle: "Invalid Data Form", message: "City must be at least 5 characters in length and less than 100")
            return
        }
        //-----------------------------------
        //Check state
        //-----------------------------------
        var found: Bool = false
        for sta in 0...(stateAbbreviations.count-1) {
            if (stateAbbreviations[sta] == State){
                found = true
                break
            }
        }
        if (found == false) {
            presentAlert(withTitle: "Invalid Data Form", message: "state code is not valid")
            return
        }
        
        //-----------------------------------
        //Check Zip: 5 characters and only DIGITS
        //-----------------------------------
        let Zip_filtered = Zip.filter { $0.isNumber }
        if Zip != Zip_filtered {
            presentAlert(withTitle: "Invalid Data Form", message: "Zip is not valid")
            return
        }
        if (Zip.count != 5){
            presentAlert(withTitle: "Invalid Data Form", message: "Zip's number must be 5")
            return
        }
        //-----------------------------------
        //Check phone number: 10 characters and only DIGITS
        //-----------------------------------
        let PhoneNumber_filtered = Phone_Number.filter{ $0.isNumber }
        if Phone_Number != PhoneNumber_filtered{
            presentAlert(withTitle: "Invalid Data Form", message: "Phone number is not valid")
            return
        }
        if (Phone_Number.count != 10){
            presentAlert(withTitle: "Invalid Data Form", message: "Phone number must be 10")
            return
        }
        //-----------------------------------
        //Check Email Address: At least 5 chars, a "@", "." char
        //-----------------------------------
        var a:Bool = false
        let char_a = Email_Address.filter{ $0 == "@"}
        let char_b = Email_Address.filter{ $0 == "."}
        let EmaliTrimmed = Email_Address.replacingOccurrences(of: " ", with: "")
        if (EmaliTrimmed != Email_Address) {
            presentAlert(withTitle: "Invalid Data Form", message: "Email Address is not valid")
            return
        }
        if Email_Address==""{
            a = true
            presentAlert(withTitle: "Invalid Data Form", message: "Email Address is not valid")
            return
        }
        if char_a != "@"{

            a = true
            presentAlert(withTitle: "Invalid Data Form", message: "Email Address is not valid")
            return

        }
        if char_b != "."{

            a = true
            presentAlert(withTitle: "Invalid Data Form", message: "Email Address is not valid")
            return

        }

        if a==false{
            let index = Email_Address.firstIndex(of: "@")
            let char_0 = Email_Address.suffix(from: index!)
            let char_1 = char_0.filter{ $0 == "."}
            if char_1 != "."{
                presentAlert(withTitle: "Invalid Data Form", message: "Email Address is not valid")
                return
            }

        }
        if Email_Address.count < 5 {
            presentAlert(withTitle: "Invalid Data Form", message: "Email Address is at least 5")
            return
        }
        //-----------------------------------
        //Check mobile phone 10 characters and only DIGITS
        //-----------------------------------
        let Mobile_phone_filtered = Mobile_phone.filter{ $0.isNumber }
        if Mobile_phone != Mobile_phone_filtered{
            presentAlert(withTitle: "Invalid Data Form", message: "Mobile Phone number is not valid")
            return
        }
        if (Mobile_phone.count != 10){
            presentAlert(withTitle: "Invalid Data Form", message: "Mobile Phone number must be 10")
            return
        }
        //-----------------------------------
        // Check Mobile Carrier: Verizon, AT&T, T-Mobile are valid
        //-----------------------------------
        for mc in MobileCarrier {
            if (mc == Mobile_Carrier) {
                    found2 = true
                    break
                }
        }
        if found2 == false {
            presentAlert(withTitle: "Invalid Data Form", message: "Mobile Carrier is not valid")
            return
        }
        //-----------------------------------
        //Check Username: At least 10 chars, no blank chars
        //-----------------------------------
        let UsernameTrimmed = Username.replacingOccurrences(of: " ", with: "")
        if (UsernameTrimmed==""){
            presentAlert(withTitle: "Invalid Data Form", message: "Username can not be blank!")
            return
        }
        if (UsernameTrimmed != Username) {
            presentAlert(withTitle: "Invalid Data Form", message: "Username can not be blank!")
            return
        }
        if (UsernameTrimmed.count<10 || UsernameTrimmed.count>=100){
            presentAlert(withTitle: "Invalid Data Form", message: "Username must be at least 5 characters in length and less than 100")
            return
        }
        //-----------------------------------
        //Check Password: At least 10 chars, one upper case
        //-----------------------------------
        let CheckPassword = NSPredicate(format: "SELF MATCHES %@ ", "(?=.*[A-Z]).{10,}$")
        if !CheckPassword.evaluate(with: Password){
            presentAlert(withTitle: "Invalid Data Form", message: "Password is at least 10 chars, one upper case")
            return
        }
        //-----------------------------------
        //Check Re-Password: equal to password
        //-----------------------------------
        if Password != Re_Password{
            presentAlert(withTitle: "Invalid Data Form", message: "Password is not equal to Re-password")
            return
        }
        // All OK
        result_message = "Success"
        //-----------------------------------
        
        
    }
    
} //end struct




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
