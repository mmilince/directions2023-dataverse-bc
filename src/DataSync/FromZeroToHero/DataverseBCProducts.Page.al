page 50152 "Dataverse BC Products"
{
    ApplicationArea = All;
    Caption = 'Dataverse BC Products';
    PageType = List;
    SourceTable = "CDS cr438_BCProductNew";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(cr438_BCProductId; Rec.cr438_BCProductNewId)
                {
                    ToolTip = 'Specifies the value of the BCProductId field.';
                }
                field(cr438_BCProductName; Rec.cr438_Name)
                {
                    ToolTip = 'Specifies the value of the BCProductName field.';
                }
                field(cr438_BCProductNumber; Rec.cr438_Code)
                {
                    ToolTip = 'Specifies the value of the BCProductNumber field.';
                }
                field(cr438_BCProductUnitCost; Rec.cr438_UnitCost)
                {
                    ToolTip = 'Specifies the value of the BCProductUnitCost field.';
                }
                field(cr438_BCProductUnitPrice; Rec.cr438_UnitPrice)
                {
                    ToolTip = 'Specifies the value of the BCProductUnitPrice field.';
                }
                field(cr438_BCProductVendorCode; Rec.cr438_VendorNo)
                {
                    ToolTip = 'Specifies the value of the BCProductVendorCode field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateFromDataverse)
            {
                ApplicationArea = All;
                Caption = 'Create in Business Central';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Generate the table from the coupled Microsoft Dataverse worker.';

                trigger OnAction()
                var
                    BCProduct: Record "CDS cr438_BCProductNew";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CurrPage.SetSelectionFilter(BCProduct);
                    CRMIntegrationManagement.CreateNewRecordsFromCRM(BCProduct);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledDataverseWorker(BCProduct: Record "CDS cr438_BCProductNew")
    begin
        CurrentlyCoupledBCProduct := BCProduct;
    end;

    var
        CurrentlyCoupledBCProduct: Record "CDS cr438_BCProductNew";
}
