pageextension 50116 Ex_Sales_Quot extends "Sales Quote"
{
    layout
    {
        addafter("Work Description")
        {
            field(Validity; Validity)
            {
                ApplicationArea = All;
            }
            field(Location; Location)
            {
                ApplicationArea = All;
            }
            field("Client Location"; "Client Location")
            {
                ApplicationArea = All;
            }
            field(Exclusion; Exclusion)
            {
                ApplicationArea = All;
            }
            field(Completion; Completion)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        addafter(SendApprovalRequest)
        {
            Action("Report")
            {
                ApplicationArea = All;
                Caption = 'Report';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    SalesQutRep: Report "Sales Quote";
                    SalesHeadRec: Record "Sales Header";
                begin
                    Clear(SalesQutRep);
                    SalesHeadRec.SetRange("No.", "No.");
                    SalesQutRep.SetTableView(SalesHeadRec);
                    SalesQutRep.RunModal();
                end;
            }
        }

    }


}