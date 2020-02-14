pageextension 50115 FA_Card_Ex extends "Fixed Asset Card"
{
    layout
    {
        addafter(Insured)
        {
            field("Vessel No."; "Vessel No.")
            {
                ApplicationArea = All;
            }
            field("Vessels Name"; "Vessels Name") { ApplicationArea = All; }
            field("Vessels Image"; "Vessels Image")
            {
                StyleExpr = 'Picture';
                ApplicationArea = All;
            }
            field(IMO; IMO) { ApplicationArea = All; }
            field("Ship Owner"; "Ship Owner") { ApplicationArea = All; }
            field(Flag; Flag) { ApplicationArea = All; }
            field("Mortgagee Bank"; "Mortgagee Bank") { ApplicationArea = All; }
            field("Year of Built"; "Year of Built") { ApplicationArea = All; }
            field("Purchase Date"; "Purchase Date") { ApplicationArea = All; }
            field("Vessel type"; "Vessel type") { ApplicationArea = All; }
            field(Size; Size) { ApplicationArea = All; }
            field("Deck Area"; "Deck Area") { ApplicationArea = All; }
            field("Crane Capacity"; "Crane Capacity") { ApplicationArea = All; }
            field("Other Description"; "Other Description") { ApplicationArea = All; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}