tableextension 50112 "Ex_Table Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "Received by"; Text[30])
        { }
    }

    var
        myInt: Integer;
}
pageextension 50112 "Ex_Page Posted Purchase Rec" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Received by"; "Received by")
            {
                Editable = false;
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        addafter(Statistics)
        {
            Action("Sales Invoice Summary Report")
            {
                ApplicationArea = All;
                Caption = 'MRN Report';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    GRNRep: Report "MRN Report";
                    PosPurRec: Record "Purch. Rcpt. Header";
                begin
                    Clear(GRNRep);
                    PosPurRec.SetRange("No.", "No.");
                    GRNRep.SetTableView(PosPurRec);
                    GRNRep.RunModal();
                end;
            }
        }

    }
}