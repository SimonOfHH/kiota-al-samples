// <auto-generated/>
namespace PetStoreAl.models;

using SimonOfHH.Kiota.Definitions;
using SimonOfHH.Kiota.Utilities;

codeunit 50022 Order implements "Kiota IModelClass SOHH"
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
    var
        #pragma warning disable AA0021,AA0202
        complete: Boolean;
        id, petId: BigInteger;
        quantity: Integer;
        shipDate: DateTime;
        status: Enum "Order_status";
        #pragma warning restore AA0021,AA0202
    begin
        complete := Complete();
        id := Id();
        petId := PetId();
        quantity := Quantity();
        shipDate := ShipDate();
        status := Status();
    end;
    procedure Complete() : Boolean
    begin
        if JsonBody.SelectToken('complete', SubToken) then
            exit(SubToken.AsValue().AsBoolean());
    end;
    procedure Id() : BigInteger
    begin
        if JsonBody.SelectToken('id', SubToken) then
            exit(SubToken.AsValue().AsBigInteger());
    end;
    procedure PetId() : BigInteger
    begin
        if JsonBody.SelectToken('petId', SubToken) then
            exit(SubToken.AsValue().AsBigInteger());
    end;
    procedure Quantity() : Integer
    begin
        if JsonBody.SelectToken('quantity', SubToken) then
            exit(SubToken.AsValue().AsInteger());
    end;
    procedure ShipDate() : DateTime
    begin
        if JsonBody.SelectToken('shipDate', SubToken) then
            exit(SubToken.AsValue().AsDateTime());
    end;
    procedure Status() : Enum "Order_status"
    begin
        if JsonBody.SelectToken('status', SubToken) then
            exit(Enum::Order_status.FromInteger(Enum::Order_status.Ordinals().Get(Enum::Order_status.Names().IndexOf(SubToken.AsValue().AsText()))));
    end;
    procedure ToJson() : JsonToken
    begin
        exit(JsonBody);
    end;
    #pragma warning disable AA0245
    procedure ToJson(complete : Boolean; id : BigInteger; petId : BigInteger; quantity : Integer; shipDate : DateTime; status : Enum "Order_status") : JsonToken
    #pragma warning restore AA0245
    var
        TargetJson: JsonObject;
    begin
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'complete', complete);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'id', id);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'petId', petId);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'quantity', quantity);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'shipDate', shipDate);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'status', status.AsInteger());
        exit(TargetJson.AsToken());
    end;
}
