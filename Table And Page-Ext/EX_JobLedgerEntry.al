pageextension 50113 "Ex Job Ledg Entry" extends "Job Ledger Entries"
{
    layout
    {

    }

    actions
    {
        addafter("&Navigate")
        {
            Action("Issue Voucher")
            {
                ApplicationArea = All;
                Caption = 'Issue Voucher';
                Promoted = true;
                PromotedOnly = true;
                Image = Print;
                trigger OnAction();
                var
                    IssueVouchr: Report "Issue Voucher";
                    JobLegEnt: Record "Job Ledger Entry";
                    JobLegEnt2: Record "Job Ledger Entry";
                    DocNo: Code[20];
                begin
                    Clear(IssueVouchr);
                    CurrPage.SetSelectionFilter(JobLegEnt);
                    IF JobLegEnt.FindFirst() then begin

                        JobLegEnt2.Reset();
                        JobLegEnt2.SetRange("Document No.", JobLegEnt."Document No.");
                        If JobLegEnt2.FindFirst() then begin
                            IssueVouchr.SetTableView(JobLegEnt2);
                            IssueVouchr.RunModal();
                        end;
                    end;
                end;


            }
        }
    }

    var
        myInt: Integer;
}