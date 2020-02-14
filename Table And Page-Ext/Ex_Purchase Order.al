tableextension 50111 "Ex_Table Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "Received by"; Text[30]) { }
        field(50001; "Redyness Date"; Date) { }
        field(50002; "Validity Date"; Date) { }
        //</LT_02Jan20>
        field(50003; "Packing Instruction"; Text[100]) { }
        field(50004; "Port of Call/Delivery Address"; Text[100]) { }
        field(50005; "Warranty, if any"; Boolean) { }
        field(50006; "Certificate(s), if required"; Boolean) { }
        //</Lt_02Jan20>
    }

    var
        myInt: Integer;
}
pageextension 50111 "Ex_PagePurchaseOrder" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("Received by"; "Received by")
            {
                ApplicationArea = All;
            }

        }
        addafter("Order Date")
        {
            field("Redyness Date"; "Redyness Date")
            {
                ApplicationArea = All;
            }
            field("Validity Date"; "Validity Date")
            {
                ApplicationArea = All;
            }
            field("Packing Instruction"; "Packing Instruction")
            {
                ApplicationArea = All;
            }
            field("Port of Call/Delivery Address"; "Port of Call/Delivery Address")
            {
                ApplicationArea = All;
            }
            field("Warranty, if any"; "Warranty, if any")
            {
                ApplicationArea = All;
            }
            field("Certificate(s), if required"; "Certificate(s), if required")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addafter("&Print")
        {
            Action("New Purchase Order")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order Local';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    PoRep: Report "PO Report";
                    PoRec: Record "Purchase Header";
                begin
                    Clear(PoRep);
                    PoRec.SetRange("No.", "No.");
                    PoRep.SetTableView(PoRec);
                    PoRep.RunModal();
                end;
            }
            Action("New Purchase Order 2")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order Export';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    Po2Rep: Report "PO Report Export";
                    PoRec: Record "Purchase Header";
                begin
                    Clear(Po2Rep);
                    PoRec.SetRange("No.", "No.");
                    Po2Rep.SetTableView(PoRec);
                    Po2Rep.RunModal();
                end;
            }
        }
    }

    var
        myInt: Integer;
}