codeunit 50152 "RM Customer Account Sync Mgt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetCustomerAccountMapping', '', true, true)]
    local procedure OnAfterResetCustomerAccountMapping(IntegrationTableMappingName: Code[20])
    var
        CRMContact: Record "CRM Account";
        Contact: Record Customer;
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(
            IntegrationTableMappingName,
            Contact.FieldNo("External No."),
            CRMContact.FieldNo(cr438_ExternalNumber),
            IntegrationFieldMapping.Direction::Bidirectional,
            '',
            true,
            false);
    end;
}