Codeunit 50151 "RM User Status Business Event"
{
    [EventSubscriber(ObjectType::Table, Database::User, 'OnAfterValidateEvent', 'State', false, false)]
    local procedure OnAfterValidateState(var Rec: Record User; var xRec: Record User)
    var
        User: Record User;
    begin
        if Rec.State = xRec.State then
            exit;

        BusinessEventUserState(Rec.SystemId, Rec."User Security ID", Rec."Full Name", Rec.State = Rec.State::Enabled);
    end;

    [ExternalBusinessEvent('UserState', 'Change User State', 'This business event is triggered when a user state is changed', Enum::EventCategory::"User Status Events", '1.0')]
    local procedure BusinessEventUserState(UserId: Guid; UserSecurityId: Guid; FullName: Text[80]; IsEnabled: Boolean)
    begin
    end;
}