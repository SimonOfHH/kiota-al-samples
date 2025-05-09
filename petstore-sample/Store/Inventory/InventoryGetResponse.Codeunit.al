// <auto-generated/>
namespace PetStoreAl.store.inventory;

using SimonOfHH.Kiota.Definitions;
using SimonOfHH.Kiota.Utilities;

codeunit 50009 InventoryGetResponse implements "Kiota IModelClass SOHH"
{
    Access = Internal;

    var
        #pragma warning disable AA0137
        JSONHelper: Codeunit "JSON Helper SOHH";
        #pragma warning restore AA0137
        JsonBody, SubToken: JsonToken;
        DebugCall: Boolean;
    procedure SetBody(NewJsonBody : JsonToken) 
    begin
        SetBody(NewJsonBody, false);
    end;
    procedure SetBody(NewJsonBody : JsonToken; Debug : Boolean) 
    begin
        JsonBody := NewJsonBody;
        if (Debug) then begin
            #pragma warning disable AA0206
            DebugCall := true;
            #pragma warning restore AA0206
            ValidateBody();
        end;
    end;
    local procedure ValidateBody() 
    begin
    end;
    procedure ToJson() : JsonToken
    begin
        exit(JsonBody);
    end;
}
