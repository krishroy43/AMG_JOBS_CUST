pageextension 50117 Ex_SaleQuote_Subform extends "Sales Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field(Bold; Bold)
            {
                ApplicationArea = All;
            }
            field(Underline; Underline)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}