codeunit 50153 "Data Sync Mgt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var Handled: Boolean)
    begin
        if BCTableNo = Database::"RM Product" then begin
            CDSTableNo := Database::"CDS cr438_BCProductNew";
            Handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        if CRMTableID = Database::"CDS cr438_BCProductNew" then
            Handled := LookupBCProduct(SavedCRMId, CRMId, IntTableFilter);
    end;

    local procedure LookupBCProduct(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        BCProduct: Record "CDS cr438_BCProductNew";
        OriginalBCProduct: Record "CDS cr438_BCProductNew";
        DataverseBCProducts: Page "Dataverse BC Products";
    begin
        if not IsNullGuid(CRMId) then begin
            if BCProduct.Get(CRMId) then
                DataverseBCProducts.SetRecord(BCProduct);
            if not IsNullGuid(SavedCRMId) then
                if OriginalBCProduct.Get(SavedCRMId) then
                    DataverseBCProducts.SetCurrentlyCoupledDataverseWorker(OriginalBCProduct);
        end;

        BCProduct.SetView(IntTableFilter);
        DataverseBCProducts.SetTableView(BCProduct);
        DataverseBCProducts.LookupMode(true);
        if DataverseBCProducts.RunModal = ACTION::LookupOK then begin
            DataverseBCProducts.GetRecord(BCProduct);
            CRMId := BCProduct.cr438_BCProductNewId;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);
    var
        CRMSetupDefaults: Codeunit "CRM Setup Defaults";
    begin
        CRMSetupDefaults.AddEntityTableMapping('bcproduct', Database::"RM Product", TempNameValueBuffer);
        CRMSetupDefaults.AddEntityTableMapping('bcproduct', Database::"CDS cr438_BCProductNew", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnBeforeResetConfiguration', '', false, false)]
    local procedure HandleOnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup")
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        BCProduct: Record "CDS cr438_BCProductNew";
        Product: Record "RM Product";
    begin
        InsertIntegrationTableMapping(
            IntegrationTableMapping, 'PRODUCT-BCPRODUCT',
            Database::"RM Product", Database::"CDS cr438_BCProductNew",
            BCProduct.FieldNo(cr438_BCProductNewId), BCProduct.FieldNo(ModifiedOn),
            '', '', true);

        InsertIntegrationFieldMapping('PRODUCT-BCPRODUCT', Product.FieldNo(Code), BCProduct.FieldNo(cr438_Code), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('PRODUCT-BCPRODUCT', Product.FieldNo(Name), BCProduct.FieldNo(cr438_Name), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('PRODUCT-BCPRODUCT', Product.FieldNo("Vendor No."), BCProduct.FieldNo(cr438_VendorNo), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('PRODUCT-BCPRODUCT', Product.FieldNo("Unit Cost"), BCProduct.FieldNo(cr438_UnitCost), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('PRODUCT-BCPRODUCT', Product.FieldNo("Unit Price"), BCProduct.FieldNo(cr438_UnitPrice), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::Bidirectional, 'Dataverse');
    end;

    local procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
            ConstValue, ValidateField, ValidateIntegrationTableField);
    end;
}