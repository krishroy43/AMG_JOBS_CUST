page 50115 "Vessel Selection Master Card"
{
    PageType = Card;
    // ApplicationArea = All;
    // UsageCategory = Lists;
    Caption = 'Vessel Master Card';
    SourceTable = "VesselMaster Table";
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Vessel No."; "Vessel No.") { ApplicationArea = All; }
                field("GD Value"; "Project Dimention") { ApplicationArea = All; }
                field("Vessels Name"; "Vessels Name")
                { ApplicationArea = All; }
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
        area(Factboxes)
        {

        }
    }

    actions
    {

    }
}