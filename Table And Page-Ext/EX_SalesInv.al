tableextension 50103 Ex_SalesLine extends "Sales Line"
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

        field(50005; "withholding"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Withholding Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Bold; Boolean)
        {

        }
        field(50008; Underline; Boolean) { }


    }

    var
        myInt: Integer;
}
pageextension 50103 "Ex_SaleInv" extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Line Number"; "Line Number")
            { ApplicationArea = All; }
            field("Contract No"; "Contract No")
            { ApplicationArea = All; }
            field("Cost of Revenue"; "Cost of Revenue")
            { ApplicationArea = All; }
            Field(Retention; Retention)
            { ApplicationArea = All; }
            field(withholding; withholding)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Withholding Tax"; "Withholding Tax")
            {
                ApplicationArea = All;
            }
        }
    }


}