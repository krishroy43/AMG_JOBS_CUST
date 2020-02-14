tableextension 50106 Ex_PosSalesHead extends "Sales Invoice Header"
{

    fields
    {
        Field(50000; "Invoice Period"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
    }

    var
        myInt: Integer;
}

pageextension 50106 EX_PosSalesInvoiceHead extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Due Date")
        {
            field("Invoice Period"; "Invoice Period")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Bank Account"; "Bank Account")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(Print)
        {
            Action("Sales Invoice Report")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice Aramco';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    SalRep: Report "Sales Invoice Report";
                    PosSalInv: Record "Sales Invoice Header";
                begin
                    Clear(SalRep);
                    PosSalInv.SetRange("No.", "No.");
                    SalRep.SetTableView(PosSalInv);
                    SalRep.RunModal();
                end;
            }
            Action("Sales Invoice Summary Report")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice Aramco Summary';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    SummRep: Report "Sales Invoice Summary Report";
                    PosSalInv: Record "Sales Invoice Header";
                begin
                    Clear(SummRep);
                    PosSalInv.SetRange("No.", "No.");
                    SummRep.SetTableView(PosSalInv);
                    SummRep.RunModal();
                end;
            }
            Action("Export Invoice")
            {
                ApplicationArea = All;
                Caption = 'Export Invoice Report';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    ExpRep: Report "Export Invoice";
                    PosSalInv: Record "Sales Invoice Header";
                begin
                    Clear(ExpRep);
                    PosSalInv.SetRange("No.", "No.");
                    ExpRep.SetTableView(PosSalInv);
                    ExpRep.RunModal();
                end;
            }
            Action("Local Invoice")
            {
                ApplicationArea = All;
                Caption = 'Local Invoice Report';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    LocRep: Report "Local Invoice";
                    PosSalInv: Record "Sales Invoice Header";
                begin
                    Clear(LocRep);
                    PosSalInv.SetRange("No.", "No.");
                    LocRep.SetTableView(PosSalInv);
                    LocRep.RunModal();
                end;
            }
        }
    }

    var
        myInt: Integer;
}