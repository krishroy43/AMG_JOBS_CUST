pageextension 50110 JobPageExtension extends "Job Card"
{
    layout
    {
        addafter("Project Manager")
        {
            field("Vessel No."; "Vessel No.")
            {
                ApplicationArea = All;
                Caption = 'Vessel No.';
            }

            field("Contract No."; "Contract No.")
            {
                ApplicationArea = all;
                Caption = 'Contract No.';
            }
            field(Loction; Loction)
            {
                ApplicationArea = all;
                Caption = 'Location';
            }
        }
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                AddDimension: codeunit "Create Document";
            begin
                CurrPage.Update();
                if "Bill-to Customer No." <> '' then begin
                    AddDimension.CreateDefaultDimesnion("No.");
                    CreateDimesnionForVessel;
                end;
            end;
        }
    }
    actions
    {
        addafter("&Copy")
        {
            Action("Job Cost Analysis")
            {
                ApplicationArea = All;
                Caption = 'Job Cost Analysis';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    JobRep: Report "Job Cost Analysis";
                    JobRec: Record Job;
                begin
                    Clear(JobRep);
                    JobRec.SetRange("No.", "No.");
                    JobRep.SetTableView(JobRec);
                    JobRep.RunModal();
                end;
            }
        }
    }

}