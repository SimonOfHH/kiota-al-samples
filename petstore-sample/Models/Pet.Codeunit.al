// <auto-generated/>
namespace PetStoreAl.models;

using SimonOfHH.Kiota.Definitions;
using SimonOfHH.Kiota.Utilities;

codeunit 50018 Pet implements "Kiota IModelClass SOHH"
{

    var
        #pragma warning disable AA0137
        JSONHelper: Codeunit "JSON Helper SOHH";
        #pragma warning restore AA0137
        JsonBody: JsonObject;
        SubToken: JsonToken;
        DebugCall: Boolean;
    procedure SetBody(NewJsonBody : JsonObject) 
    begin
        SetBody(NewJsonBody, false);
    end;
    procedure SetBody(NewJsonBody : JsonObject; Debug : Boolean) 
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
        category: Codeunit "Category";
        id: BigInteger;
        name: Text;
        photoUrls: List of [Text];
        status: Enum "Pet_status";
        tags: List of [Codeunit "Tag"];
        #pragma warning restore AA0021,AA0202
    begin
        category := Category();
        id := Id();
        name := Name();
        photoUrls := PhotoUrls();
        status := Status();
        tags := Tags();
        Category(category);
        Id(id);
        Name(name);
        PhotoUrls(photoUrls);
        Status(status);
        Tags(tags);
    end;
    procedure Category() : Codeunit "Category"
    var
        TargetCodeunit: Codeunit "Category";
    begin
        if JsonBody.SelectToken('category', SubToken) then begin
            TargetCodeunit.SetBody(SubToken.AsObject(), DebugCall);
            exit(TargetCodeunit);
        end;
    end;
    procedure Category(p : Codeunit "Category") 
    begin
        if JsonBody.SelectToken('category', SubToken) then
            JsonBody.Replace('category', p.ToJson())
        else
            JsonBody.Add('category', p.ToJson());
    end;
    procedure Id() : BigInteger
    begin
        if JsonBody.SelectToken('id', SubToken) then
            exit(SubToken.AsValue().AsBigInteger());
    end;
    procedure Id(p : BigInteger) 
    begin
        if JsonBody.SelectToken('id', SubToken) then
            JsonBody.Replace('id', p)
        else
            JsonBody.Add('id', p);
    end;
    procedure Name() : Text
    begin
        if JsonBody.SelectToken('name', SubToken) then
            exit(SubToken.AsValue().AsText());
    end;
    procedure Name(p : Text) 
    begin
        if JsonBody.SelectToken('name', SubToken) then
            JsonBody.Replace('name', p)
        else
            JsonBody.Add('name', p);
    end;
    procedure PhotoUrls() CodeunitList: List of [Text]
    var
        JArray: JsonArray;
        JToken: JsonToken;
    begin
        if not JsonBody.SelectToken('photoUrls', SubToken) then
            exit;
        JArray := SubToken.AsArray();
        foreach JToken in JArray do 
            CodeunitList.Add(SubToken.AsValue().AsText());
    end;
    procedure PhotoUrls(p : List of [Text]) 
    var
        v: Text;
        JArray: JsonArray;
    begin
        foreach v in p do
            JArray.Add(v);
        if JsonBody.SelectToken('photoUrls', SubToken) then
            JsonBody.Replace('photoUrls', JArray)
        else
            JsonBody.Add('photoUrls', JArray);
    end;
    procedure Status(p : Enum "Pet_status") 
    begin
        if JsonBody.SelectToken('status', SubToken) then
            JsonBody.Replace('status', Format(p))
        else
            JsonBody.Add('status', Format(p));
    end;
    procedure Status() : Enum "Pet_status"
    var
        value: Enum "Pet_status";
        Ordinal: Integer;
        Ordinals: List of [Integer];
    begin
        if JsonBody.SelectToken('status', SubToken) then begin
            // Return value based on captions; needed because it's possible that the "Names" differ from the captions
            Ordinals := Enum::Pet_status.Ordinals();
            foreach Ordinal in Ordinals do begin
                value := Enum::Pet_status.FromInteger(Ordinal);
                if (Format(value) = SubToken.AsValue().AsText()) then
                    exit(value);
            end;
        Error('Invalid value for status: %1', SubToken.AsValue().AsText());
        end;
    end;
    procedure Tags(p : List of [Codeunit "Tag"]) 
    var
        v: Codeunit "Tag";
        JArray: JsonArray;
    begin
        foreach v in p do
            JSONHelper.AddToArrayIfNotEmpty(JArray, v);
        if JsonBody.SelectToken('tags', SubToken) then
            JsonBody.Replace('tags', JArray)
        else
            JsonBody.Add('tags', JArray);
    end;
    procedure Tags() CodeunitList: List of [Codeunit "Tag"]
    var
        TargetCodeunit: Codeunit "Tag";
        JArray: JsonArray;
        JToken: JsonToken;
    begin
        if not JsonBody.SelectToken('tags', SubToken) then
            exit;
        JArray := SubToken.AsArray();
        foreach JToken in JArray do begin
            Clear(TargetCodeunit);
            TargetCodeunit.SetBody(JToken.AsObject(), DebugCall);
            CodeunitList.Add(TargetCodeunit);
        end;
    end;
    procedure ToJson() : JsonObject
    begin
        exit(JsonBody);
    end;
    #pragma warning disable AA0245
    procedure ToJson(category : Codeunit "Category"; id : BigInteger; name : Text; photoUrls : List of [Text]; status : Enum "Pet_status"; tags : List of [Codeunit "Tag"]) : JsonObject
    #pragma warning restore AA0245
    var
        #pragma warning disable AA0021
        TargetJson: JsonObject;
        tag: Codeunit "Tag";
        tagsArray: JsonArray;
        #pragma warning restore AA0021
    begin
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'category', category.ToJson().AsToken());
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'id', id);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'name', name);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'photoUrls', photoUrls);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'status', Format(status));
        foreach tag in tags do
            JSONHelper.AddToArrayIfNotEmpty(tagsArray, tag);
        JSONHelper.AddToObjectIfNotEmpty(TargetJson, 'tags', tagsArray);
        exit(TargetJson);
    end;
}
