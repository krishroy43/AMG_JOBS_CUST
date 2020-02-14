tableextension 50105 Ex_SalesHead extends "Sales Header"
{

    fields
    {
        Field(50000; "Invoice Period"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "Banck Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }

        field(50002; "Withholding Tax Percentage"; Option)
        {
            OptionMembers = "5","10","15";
        }

        field(50003; "Witholding Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."Unit Price" where("Document No." = field("No."), withholding = const(true)));
            Editable = false;
        }
        field(50004; Validity; Text[250]) { }
        field(50005; "Client Location"; Text[50]) { }
        field(50006; Exclusion; Text[250]) { }
        field(50007; Completion; Text[50]) { }
        field(50008; Location; Text[50]) { }


    }
    var
        myInt: Integer;
}

pageextension 50105 EX_SalesInvoice extends "Sales Invoice"
{
    layout
    {
        addafter("Due Date")
        {
            field("Invoice Period"; "Invoice Period")
            {
                ApplicationArea = All;
            }
            field("Banck Account"; "Banck Account")
            {
                ApplicationArea = All;
            }
            field("Withholding Tax Percentage"; "Withholding Tax Percentage")
            {
                ApplicationArea = All;
            }
            field("Shipping No. Series"; "Shipping No. Series")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addafter(Statistics)
        {
            action("Update Witholding tax")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = UpdateXML;
                ApplicationArea = All;

                trigger OnAction();
                var
                    saleslinerec: Record "Sales Line";
                    salesinvLinerec: Record "Sales Line";
                    salesRecset: Record "Sales & Receivables Setup";
                    totalval: Decimal;
                    percent: Decimal;
                begin
                    clear(totalval);
                    salesRecset.Get();
                    if not salesRecset."Withholding Tax Customisation" then
                        exit;

                    salesRecset.TestField("Withholding Tax Acoount");
                    saleslinerec.Reset();
                    saleslinerec.SetRange("Document Type", saleslinerec."Document Type"::Invoice);
                    saleslinerec.SetRange("Document No.", Rec."No.");
                    if saleslinerec.FindSet then
                        repeat
                            totalval += saleslinerec.Amount;
                        until saleslinerec.Next = 0;


                    saleslinerec.Reset();
                    saleslinerec.SetRange("Document Type", saleslinerec."Document Type"::Invoice);
                    saleslinerec.SetRange("Document No.", Rec."No.");
                    if saleslinerec.FindLast then;

                    Evaluate(percent, FORMAT(Rec."Withholding Tax Percentage"));

                    salesinvLinerec.Reset();
                    salesinvLinerec.SetRange("Document Type", salesinvLinerec."Document Type"::Invoice);
                    salesinvLinerec.SetRange("Document No.", Rec."No.");
                    salesinvLinerec.SetRange(withholding, true);
                    if not salesinvLinerec.FindFirst() then begin

                        salesinvLinerec.Validate("Document Type", saleslinerec."Document Type");
                        salesinvLinerec.Validate("Document No.", saleslinerec."Document No.");
                        salesinvLinerec.Validate("Line No.", saleslinerec."Line No." + 10000);
                        salesinvLinerec.Validate(Type, salesinvLinerec.Type::"G/L Account");
                        salesinvLinerec.Validate("No.", salesRecset."Withholding Tax Acoount");
                        salesinvLinerec.Validate(Quantity, 1);
                        salesinvLinerec.validate("Unit Price", -totalval * (percent / 100));
                        //salesinvLinerec.Amount := -totalval * (Rec."Withholding Tax Percentage" / 100);
                        salesinvLinerec.withholding := true;
                        salesinvLinerec.Insert;
                    end else
                        Error('Already a line for witholding tax exists');
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SalAndRecSetup.Get();
        If "Banck Account" = '' then
            "Banck Account" := SalAndRecSetup."bank Account";
        "Withholding Tax Percentage" := SalAndRecSetup."Withholding Tax Percentage";

    end;

    var
        SalAndRecSetup: Record "Sales & Receivables Setup";


}