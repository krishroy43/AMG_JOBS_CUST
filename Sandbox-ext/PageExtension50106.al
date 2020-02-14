pageextension 50206 PageExtension50106 extends "General Ledger Entries"
{
    layout
    {
        modify(Description)
        {
            Visible = false;
        }
        addafter("G/L Account No.")
        {
            field("G/L Account Name56808"; "G/L Account Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("Additional-Currency Amount41042"; "Additional-Currency Amount")
            {
                ApplicationArea = All;
            }
        }
        modify("Gen. Posting Type")
        {
            Width = 10;
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
    }
    actions
    {
    }
}
