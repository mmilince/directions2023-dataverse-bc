codeunit 50150 "RM Virtual Tables Mgt"
{
    internal procedure InsertFixedAsset()
    var
        FixedAsset: Record "Fixed Asset";
        I: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FASetup: Record "FA Setup";
    begin
        FASetup.Get();
        for I := 1 to 10000 do begin
            FixedAsset.Init();
            FixedAsset.Validate("No.", NoSeriesMgt.DoGetNextNo(FASetup."Fixed Asset Nos.", 0D, true, true));
            FixedAsset.Validate(Description, 'Chair - ' + Format(I));
            FixedAsset.Validate("Responsible Employee", GetRandomEmployee());
            FixedAsset.Validate("FA Subclass Code", 'FURNITURE');
            FixedAsset.Insert(true);
        end;
        Message('inserted');
    end;

    local procedure GetRandomEmployee(): Code[20]
    var
        Employee: Code[20];
        Number: Integer;
    begin
        Number := Random(9);

        case Number of
            1:
                Employee := 'EH';
            2:
                Employee := 'JO';
            3:
                Employee := 'LT';
            4:
                Employee := 'MH';
            5:
                Employee := 'MMILINCE';
            6:
                Employee := 'OF';
            7:
                Employee := 'RB';
            8:
                Employee := 'RFAJDIGA';
            9:
                Employee := 'TD';
        end;

        exit(Employee);
    end;
}