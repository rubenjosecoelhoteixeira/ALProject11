pageextension 50110 CreditBalanceNotification extends "Sales Order"
{
    trigger OnOpenPage()
    var
        Customer: Record Customer;
        CreditBalanceNotification: Notification;
        OpenCustomer: Text;
        Text003: TextConst ENU = 'The current balance exceeds the credit limit.';
        Text004: TextConst ENU = 'Change credit limit';
    begin
        Customer.GET("Sell-to Customer No.");
        if Customer."Balance (LCY)" > Customer."Credit Limit (LCY)" then begin
            // Create the notification
            CreditBalanceNotification.Message(Text003);
            CreditBalanceNotification.Scope := NotificationScope::LocalScope;
            // Add a data property for the customer number
            CreditBalanceNotification.SetData('CustNumber', Customer."No.");
            // Add an action that calls the ActionHandler codeunit, which you define in the next step
            CreditBalanceNotification.AddAction('Text004', CODEUNIT::"ActionHandler", 'OpenCustomer');
            // Send the notification to the client
            CreditBalanceNotification.Send();
        end;
    end;
}