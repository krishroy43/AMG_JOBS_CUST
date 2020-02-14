tableextension 50102 EX_JobPlaningLine extends "Job Planning Line"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Line Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                InitJobPlanningLine();
            end;

        }
        field(50002; "Contract No"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                InitJobPlanningLine();
            end;

        }
        field(50003; "Cost of Revenue"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                InitJobPlanningLine();
            end;

        }
        field(50004; Retention; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                InitJobPlanningLine();
            end;
        }
        field(50005; Hire; Boolean)
        {
            trigger OnValidate()
            var
                VesselSelection: Record "Vessel Selection";
                JobMaster: Record Job;
            begin

                IF NOT Hire THEN begin
                    "From Date" := 0D;
                    "From Time" := 0T;
                    "To Date" := 0D;
                    "To Time" := 0T;
                END
                ELSE BEGIN
                    IF JobMaster.Get(Rec."Job No.") THEN BEGIN
                        IF VesselSelection.Get(JobMaster."Vessel No.", JobMaster."No.") THEN BEGIN
                            "From Date" := VesselSelection."Vessel Delivery Date ";
                            "From Time" := VesselSelection."Vessel Delivery Time";
                        END;
                    END;
                END;
            end;
        }
        field(50006; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "To Date" <> 0D THEN
                    IF "To Date" < "From Date" THEN
                        Error('To Date Cannot be Before From Date');
                IF "To Time" <> 0T THEN
                    Validate("To Time");
            end;
        }
        field(50007; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF ("From Date" <> 0D) AND ("To Date" <> 0D) THEN
                    "Total Days" := "To Date" - "From Date";
                IF "To Time" <> 0T THEN
                    Validate("To Time");
            end;
        }
        field(50008; "From Time"; Time)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "To Time" <> 0T THEN
                    Validate("To Time");
            end;
        }
        field(50009; "To Time"; Time)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //TotalToTime := FORMAT("To Time", 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                //Evaluate("Total Hrs", COPYSTR(TotalToTime, 10, 2));
                //TotalToTime := "To Time" - 0T;
                //TotalToTime := ((TotalToTime / 1000) / 60) / 60;

                if "To Time" <> 0T then
                    "to Time in Text" := Format("To Time");
                if "From Time" <> 0T then
                    "from time in text" := Format("From Time");
                EVALUATE(CalculatedTime, COPYSTR("to Time in Text", 1, 2));
                "to time in decimal" += Abs(CalculatedTime);
                EVALUATE(CalculatedTime, COPYSTR("to Time in Text", 4, 2));
                "to time in decimal" += Abs(CalculatedTime / 60);
                EVALUATE(CalculatedTime, COPYSTR("to Time in Text", 7, 2));
                "to time in decimal" += Abs(CalculatedTime / 3600);
                if CopyStr("to time in text", 10, 2) = 'PM' then
                    "to time in decimal" += 12;

                EVALUATE(CalculatedTime, COPYSTR("from Time in Text", 1, 2));
                "from time in decimal" += Abs(CalculatedTime);
                EVALUATE(CalculatedTime, COPYSTR("from Time in Text", 4, 2));
                "from time in decimal" += Abs(CalculatedTime / 60);
                EVALUATE(CalculatedTime, COPYSTR("from Time in Text", 7, 2));
                "from time in decimal" += Abs(CalculatedTime / 3600);
                if CopyStr("from time in text", 10, 2) = 'PM' then
                    "from time in decimal" += 12;

                "Total Days" := "To Date" - "From Date";
                IF "from time in decimal" > "to time in decimal" THEN
                    "Total Days" += ("from time in decimal" - "to time in decimal") / 24
                ELSE
                    "Total Days" += ("to time in decimal" - "from time in decimal") / 24;
                IF "Total Days" > 0 THEN
                    Validate(Quantity, "Total Days");
            end;
        }
        field(50010; "Total Days"; Decimal)
        {
            DecimalPlaces = 1 : 5;
        }

        field(50011; "Total Hrs"; Decimal)
        {

        }


    }


    trigger OnAfterInsert()
    begin
        InitJobPlanningLine();
    end;


    var
        myInt: Integer;
        TotalToTime: Duration;
        "to time in text": Text[11];
        "from time in text": Text[11];
        "to time in decimal": Decimal;
        "from time in decimal": Decimal;
        CalculatedTime: Decimal;


}
//Page 

pageextension 50102 "Ex_PlaningLine" extends "Job Planning Lines"
{
    layout
    {
        addafter("Invoiced Amount (LCY)")
        {
            field("Line Number"; "Line Number")
            { ApplicationArea = All; }
            field("Contract No"; "Contract No")
            { ApplicationArea = All; }
            field("Cost of Revenue"; "Cost of Revenue")
            { ApplicationArea = All; }
            field(Retention; Retention)
            { ApplicationArea = All; }
            field(Hire; Hire) { ApplicationArea = All; }
            field("From Date"; "From Date") { ApplicationArea = All; }
            field("From Time"; "From Time") { ApplicationArea = All; }
            field("To Date"; "To Date") { ApplicationArea = All; }
            field("To Time"; "To Time") { ApplicationArea = All; }
            field("Total Days"; "Total Days") { ApplicationArea = All; }

        }
    }

    actions
    {

        addlast(Creation)
        {
            Action("Create Lines")
            {
                ApplicationArea = All;
                Caption = 'Aramco Template';
                Promoted = true;
                PromotedOnly = true;
                Image = CreateForm;
                trigger OnAction();
                var
                    JobLineSelRec: Record "Job Line Selection";
                    JobLienPage: Page "Job Line selection";
                    jobPlanLine: Record "Job Planning Line";
                    SingInsCodeUnit: Codeunit "Single Instant Codeunit";

                begin
                    JobPlanLine.Reset();
                    SingInsCodeUnit.SetJobNo("Job No.");
                    SingInsCodeUnit.SetJobTaskNo("Job Task No.");
                    JobLineSelRec.Reset();
                    JobLienPage.SetTableView(JobLineSelRec);
                    JobLienPage.RunModal();
                    CurrPage.Update(true);
                end;
            }
        }
    }
    var
        t: Integer;

    procedure UpdatePage()
    begin
        CurrPage.Update(true);
    end;
}
