codeunit 50110 ActionHandler
{
    trigger OnRun()
    begin

    end;

    procedure OpenCustomer(CreditBalanceNotification: Notification)
    var
        CustNumber: Text;
        CustNo: Text;
        CustRec: Record Customer;
        CustPage: Page "Customer Card";
    begin
        // Get the customer number data from the SETDATA call
        CustNo := CreditBalanceNotification.GetData(CustNumber);
        // Open the Customer Card page for the customer
        if CustRec.GET(CustNo) then begin
            CustPage.SetRecord(CustRec);
            CustPage.Run();
        end else begin
            Error('Could not find Customer: ' + CustNo);
        end;
    end;
}