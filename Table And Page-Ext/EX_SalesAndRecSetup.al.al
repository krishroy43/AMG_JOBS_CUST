tableextension 50107 SalesAndRec_ExTable extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
            Caption = 'Bank';
        }

        field(50001; "Withholding Tax Customisation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Withholding Tax Acoount"; Code[20])
        {

            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }

        field(50003; "Withholding Tax Percentage"; Option)
        {
            OptionMembers = "5","10","15";
        }
    }

    var
        myInt: Integer;
}

pageextension 50107 SalesAndRec_ExPage extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Skip Manual Reservation")
        {
            field("Withholding Tax Customisation"; "Withholding Tax Customisation")
            {
                ApplicationArea = All;
            }

            field("Withholding Tax Acoount"; "Withholding Tax Acoount")
            {
                ApplicationArea = All;
            }

            field("Withholding Tax Percentage"; "Withholding Tax Percentage")
            {
                ApplicationArea = All;
            }
            field("Bank Account"; "bank Account")
            {
                ApplicationArea = All;
            }
        }
    }




    var
        myInt: Integer;
}
