report 50103 "Local Invoice"
{
    DefaultLayout = RDLC;
    //RDLCLayout = '50101_28_V2.rdl';
    Caption = 'Local Invoice';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(InvNo; "No.")
            { }
            column(Due_Date; "Due Date") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Bank_Account; "Bank Account")
            { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Sell_to_Address_2; "Sell-to Address 2")
            { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }
            column(Bill_to_City; "Bill-to City")
            { }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            { }
            column(Sell_to_Country_Region_Code; Cust_County)
            { }
            column(Sell_to_Contact; "Sell-to Contact")
            { }
            column(Cust_Phone; CustRec."Phone No.")
            { }
            column(Cust_Fax; CustRec."Fax No.")
            { }
            column(Cust_TRN; CustRec."VAT Registration No.")
            { }
            column(Doc_No; "No.")
            { }
            column(Posting_Date; FORMAT("Posting Date", 8, '<Day,2>/<Month,2>/<year,2>'))
            { }
            column(Invoice_Period; FORMAT("Invoice Period", 6, '<Month Text,3> <year,2>'))
            { }
            column(Currency_Code; CurrCode)
            { }
            column(Comp_Logo; CompInfoRec.Picture)
            { }
            column(Comp_Name; CompInfoRec.Name)
            { }
            column(Comp_Add1; CompInfoRec.Address)
            { }
            column(Comp_Add2; CompInfoRec."Address 2")
            { }
            column(Comp_City; CompInfoRec.City)
            { }
            column(Comp_Country; CompCount)
            { }
            column(Comp_Phone; CompInfoRec."Phone No.")
            { }
            column(Comp_Phone2; CompInfoRec."Phone No. 2")
            { }
            column(Comp_Fax; CompInfoRec."Fax No.")
            { }
            column(Comp_mail; CompInfoRec."E-Mail")
            { }
            column(Comp_TRN; compInfoRec."VAT Registration No.")
            { }
            column(Comp_PosCode; CompInfoRec."Post Code")
            { }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            { }
            column(Division; Division)
            { }
            //Arabic
            column(CompNameArb; CompNameArb)
            { }
            column(PosNoArb; PosNoArb)
            { }
            column(CityArb; CityArb)
            { }
            column(CountryArb; CountryArb)
            { }
            column(MailArb; MailArb)
            { }
            column(BankName; BankName)
            { }
            column(BankNo; BankNo)
            { }
            column(BankSwitCode; BankSwitCode)
            { }
            column(BankIbnNo; BankIbnNo)
            { }
            column(Your_Reference; "Your Reference")
            { }
            column(Currency_Factor; Currency_Factor)
            { }
            column(Vessalname; Vessalname)
            { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(No_; "No.")
                { }
                column(Description; Description)
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_Price; V_UnitPrice)
                { }
                column("Vat_Amount"; "AmtVat")
                { }
                column(AmtWord; AmtWord)
                { }
                column(FaxArb; FaxArb)
                { }
                column(TelArb; TelArb)
                { }
                column(Amount_Including_VAT; AMT_IncVat)
                { }
                column(TotVAT_Per; "VAT %")
                { }
                column(Line_No_; "Line No.")
                { }
                column(SL_No; SL_No)
                { }
                column(VATPersantage; "VAT %")
                { }
                column(TotAmtIncVat; TotAmtIncVat)
                { }
                column(LocalCurr; LocalCurr)
                { }
                column(Type1; Type1)
                { }
                column(Type; Type)
                { }

                column(LineNo; LineNo)
                { }
                column(TaxAmt; TaxAmt2) { }
                trigger OnPreDataItem();
                begin
                    CheckRep.InitTextVariable;
                end;

                trigger OnAfterGetRecord();
                begin
                    Clear(AMT_IncVat);
                    If "Withholding Tax" <> 0 then
                        AMT_IncVat := "Withholding Tax" + "Line Amount"

                    Else
                        AMT_IncVat := "Line Amount";
                    Clear(AMT_IncVat2);
                    If "Withholding Tax" <> 0 then
                        AMT_IncVat2 := "Withholding Tax" + "Line Amount"

                    Else
                        AMT_IncVat2 := "Line Amount";
                    Clear(V_UnitPrice);

                    if "Withholding Tax" <> 0 then begin
                        If Quantity <> 0 then
                            V_UnitPrice := AMT_IncVat2 / Quantity
                        Else
                            V_UnitPrice := 0;


                    end else
                        V_UnitPrice := "Unit Price";
                    Clear(TotAmtIncVat);
                    SalInvRec2.Reset();
                    SalInvRec2.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    If SalInvRec2.FindSet() then begin
                        repeat
                            IF SalInvRec2."Withholding Tax" <> 0 then
                                TotAmtIncVat += (AMT_IncVat + "Withholding Tax")
                            else
                                TotAmtIncVat += AMT_IncVat
                        Until SalInvRec2.Next() = 0;
                    End;
                    if "Sales Invoice Header"."Currency Factor" <> 0 then
                        LocalCurr := TotAmtIncVat * (1 / "Sales Invoice Header"."Currency Factor")
                    else
                        LocalCurr := TotalAmt;
                    //Message('%1', TotAmtIncVat);
                    CheckRep.FormatNoText(NoText, TotAmtIncVat, '');
                    AmtWord := CurrCode + ' ' + NoText[1];
                    if ("Sales Invoice Line".Type <> "Sales Invoice Line".Type::" ") then begin
                        SL_No += 1;
                        if SL_No <> 1 then
                            Type1 := true
                        else
                            Type1 := false;
                    end
                    Else
                        Type1 := false;
                    if Vat_Per <> 0 then begin
                        Vat_Per := "VAT %";
                        If (Vat_Per = "VAT %") then
                            Vat_Per := "VAT %"
                        else
                            Vat_Per := 0;
                    end;
                    If "Withholding Tax" = 0 then begin
                        TaxAmt2 := "Amount Including VAT" - "Line Amount";
                    end else
                        TaxAmt2 := 0;
                    //Message('Amt Inc Vat%1- %1 \Line Amount %2', "Amount Including VAT", "Line Amount");
                end;

            }
            trigger OnPreDataItem();
            begin
            eND;

            trigger OnAfterGetRecord();
            begin
                if "Currency Code" = '' then begin
                    GLSetup.Get();
                    //GLSetup.CalcFields("LCY Code");
                    CurrCode := GLSetup."LCY Code";
                end Else
                    CurrCode := "Currency Code";
                if BankAccRec.Get("Bank Account") then;
                BankNo := BankAccRec."Bank Account No.";
                BankName := BankAccRec.name;
                BankIbnNo := BankAccRec.IBAN;
                BankSwitCode := BankAccRec."SWIFT Code";
                if CustRec.Get("Sell-to Customer No.") then;
                if ArabRec.Get('Company Name') then
                    CompNameArb := ArabRec."Arabic description";
                if ArabRec.Get('P O No.') then
                    PosNoArb := ArabRec."Arabic description";
                IF ArabRec.Get('City') then
                    CityArb := ArabRec."Arabic description";
                IF ArabRec.Get('Country') then
                    CountryArb := ArabRec."Arabic description";
                IF ArabRec.Get('Email') then
                    MailArb := ArabRec."Arabic description";
                if ArabRec.get('Tel') then
                    TelArb := ArabRec."Arabic description";
                if ArabRec.get('Fax') then
                    FaxArb := ArabRec."Arabic description";
                DimRec.Reset();
                DimRec.SetRange(Code, "Shortcut Dimension 1 Code");
                IF DimRec.FindFirst() then
                    Vessalname := DimRec.Name;
                DimRec.Reset();
                DimRec.SetRange(Code, "Shortcut Dimension 2 Code");
                IF DimRec.FindFirst() then
                    Division := DimRec.Name;

                IF ContReion.get(CompInfoRec."Country/Region Code") then
                    CompCount := ContReion.Name;
                if ContReion.Get("Bill-to Country/Region Code") then
                    Cust_County := ContReion.Name;
                IF "Currency Factor" <> 0 then begin
                    Currency_Factor := 1 / "Currency Factor"
                End else begin
                    Currency_Factor := 0
                end
            end;
        }

    }
    trigger OnPreReport();
    begin
        CompInfoRec.GET;
        CompInfoRec.CALCFIELDS(Picture);
    end;

    var
        CompInfoRec: Record "Company Information";
        ItemRec: Record Item;
        VendRec: Record Vendor;
        SL_No: Integer;
        TotalAmt: Decimal;
        CheckRep: Report Check;
        NoText: array[1] of Text;
        AmtWord: Text[100];
        AmtVat: Decimal;
        CustRec: Record Customer;
        ROE: Decimal;
        CurrCode: Code[10];
        ArabRec: Record "Arabic description";
        CompNameArb: Text;
        PosNoArb: Text;
        CityArb: Text;
        CountryArb: Text;
        MailArb: Text;
        TelArb: Text;
        FaxArb: Text;
        SubTotal1: Decimal;
        SubTotal2: Decimal;
        SubTotal3: Decimal;
        SubTotal4: Decimal;
        SubTotal5: Decimal;
        TotSubTotal: Decimal;
        SalInvRec2: Record "Sales Invoice Line";
        TaxAmt: Decimal;
        FinalTotAmt: Decimal;
        FinalTotAmt1: Decimal;
        GLSetup: Record "General Ledger Setup";
        LineNo: Integer;
        Blank: Boolean;
        Type1: Boolean;
        DimRec: Record "Dimension Value";
        Vessalname: Text;
        TableVisb2: Boolean;
        TableVisb3: Boolean;
        AmtIncVAT: Decimal;
        TaxableAmt: Decimal;
        NetAmount: Decimal;
        Vat_Per: Integer;
        BankName: Text;
        BankAccRec: Record "Bank Account";
        BankNo: Code[50];
        BankSwitCode: Code[50];
        BankIbnNo: Code[50];
        Division: Text;
        TotAmtIncVat: Decimal;
        LocalCurr: Decimal;
        ContReion: Record "Country/Region";
        CompCount: Text;
        AMT_IncVat: Decimal;
        AMT_IncVat2: Decimal;
        Cust_County: Text;
        V_UnitPrice: Decimal;
        Currency_Factor: Decimal;
        TaxAmt2: Decimal;
}
