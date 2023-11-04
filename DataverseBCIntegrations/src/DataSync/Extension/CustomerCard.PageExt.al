pageextension 50152 "RM Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("External No."; Rec."External No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies No. of a customer in an external system.';
            }
        }
    }
}