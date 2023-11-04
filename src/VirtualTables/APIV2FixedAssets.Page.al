page 50154 "RM APIV2 Fixed Assets"
{
    APIGroup = 'community';
    APIPublisher = 'directions2023';
    APIVersion = 'v2.0';
    EntityCaption = 'Fixed Assets';
    EntitySetCaption = 'Fixed Assets';
    DelayedInsert = true;
    EntityName = 'fixedAsset';
    EntitySetName = 'fixedAssets';
    PageType = API;
    ODataKeyFields = SystemId;
    Extensible = false;
    SourceTable = "Fixed Asset";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(class; Rec."FA Class Code")
                {
                    Caption = 'Class';
                }
                field(subclass; Rec."FA Subclass Code")
                {
                    Caption = 'Subclass';
                }
                field(inactive; Rec.Inactive)
                {
                    Caption = 'Inactive';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(responsibleEmployee; Rec."Responsible Employee")
                {
                    Caption = 'Responsible Employee';
                }
            }
        }
    }
}