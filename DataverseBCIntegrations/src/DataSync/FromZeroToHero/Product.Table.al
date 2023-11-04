table 50151 "RM Product"
{
    DataClassification = CustomerContent;
    Caption = 'Product';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }

        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }

        field(3; "Vendor No."; Text[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            Caption = 'Vendor No.';
        }

        field(4; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';
        }

        field(5; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Price';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}