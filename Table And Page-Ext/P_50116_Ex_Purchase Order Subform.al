pageextension 50108 Ex_Purchase_Order_Subform extends "Purchase Order Subform"
{
    layout
    {
        addafter("Variant Code")
        {
            field(Backcharge; Backcharge)
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