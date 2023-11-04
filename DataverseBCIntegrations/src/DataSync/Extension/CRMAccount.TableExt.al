tableextension 50151 "RM CRM Account" extends "CRM Account"
{
    fields
    {
        field(50150; cr438_ExternalNumber; Text[50])
        {
            ExternalName = 'cr438_externalnumber';
            ExternalType = 'String';
            Description = 'Id from external system.';
            Caption = 'External Number';
        }
    }
}