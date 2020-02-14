pageextension 50204 PageExtension50104 extends "G/L Entries Preview"
{
    layout
    {
        addafter(Description)
        {
            field("G/L Account Name76709"; "G/L Account Name")
            {
                ApplicationArea = All;
            }
        }
        modify(Description)
        {
            Visible = false;
        }
    }
    actions
    {
    }
}
