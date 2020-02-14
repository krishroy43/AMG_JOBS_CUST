tableextension 50104 Ex_PosSaleInvLine extends "Sales Invoice Line"
{
    fields
    {
        field(50001; "Line Number"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Contract No"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50003; "Cost of Revenue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Retention; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Withholding"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Withholding Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }



    }

    var
        myInt: Integer;
}
pageextension 50104 "Ex_PosSaleInv" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Job Task No.")
        {
            field("Line Number"; "Line Number")
            { ApplicationArea = All; }
            field("Contract No"; "Contract No")
            { ApplicationArea = All; }
            field("Cost of Revenue"; "Cost of Revenue")
            { ApplicationArea = All; }
            field(Retention; Retention)
            { ApplicationArea = All; }
            field("Withholding Tax"; "Withholding Tax") { ApplicationArea = All; }
        }
    }

}