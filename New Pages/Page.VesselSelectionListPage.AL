page 50113 "Vessel Selection List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vessel Selection";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Vessel No."; "Vessel No.") { ApplicationArea = All; }
                field(Running; Running) { ApplicationArea = All; }
                field("Contract Durtion from date"; "Contract Durtion from date") { ApplicationArea = All; }

                field("Contract Durtion to date"; "Contract Durtion to date") { ApplicationArea = All; }

                field("Contract Durtion from Time"; "Contract Durtion from Time") { ApplicationArea = All; }

                field("Contract Durtion to Time"; "Contract Durtion to Time") { ApplicationArea = All; }
                field("Extension from date"; "Extension from date") { ApplicationArea = All; }

                field("Extension to date"; "Extension to date") { ApplicationArea = All; }
                field("Extension from time"; "Extension from time") { ApplicationArea = all; }

                field("Extension to time"; "Extension to time") { ApplicationArea = all; }
                field("Vessel Delivery Date "; "Vessel Delivery Date ") { ApplicationArea = All; }

                field("Vessel Delivery Time"; "Vessel Delivery Time") { ApplicationArea = all; }

                field("Returned Date"; "Returned Date") { ApplicationArea = All; }

                field("Returned Time"; "Returned Time") { ApplicationArea = all; }
                field("Substitute Date"; "Substitute Date") { ApplicationArea = All; Editable = Substituted = true; }

                field("Substitute time"; "Substitute time") { ApplicationArea = all; Editable = Substituted = true; }
                field(Substituted; Substituted) { ApplicationArea = All; }

                field("Job No."; "Job No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
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