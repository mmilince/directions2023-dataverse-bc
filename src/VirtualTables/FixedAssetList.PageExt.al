pageextension 50150 "RM Fixed Asset List" extends "Fixed Asset List"
{
    actions
    {
        addlast(Processing)
        {
            action(InsertColors)
            {
                ApplicationArea = All;
                Caption = 'Insert Fixed Asset';

                trigger OnAction()
                var
                    VirtualTablesMgt: Codeunit "RM Virtual Tables Mgt";
                begin
                    VirtualTablesMgt.InsertFixedAsset();
                end;
            }
        }
    }
}