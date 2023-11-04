pageextension 50151 "RM Customer List" extends "Customer List"
{
    layout
    {
        addlast(Control1)
        {
            field("External No."; Rec."External No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies No. of a customer in an external system.';
            }
        }
    }
}