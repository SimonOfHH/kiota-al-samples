page 50000 ApiClientTestPage
{
    DataCaptionExpression = '';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Integer;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(FldStatus; HttpStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Specifies the status of the request.';
                }
                field(FldCompleteResponse; CompleteResponse)
                {
                    ApplicationArea = All;
                    Caption = 'Complete Response';
                    ToolTip = 'Specifies the complete response from the API.';
                    Multiline = true;
                }
            }
            group(Pet)
            {
                Caption = 'Pet';
                field(FldPetID; PetId)
                {
                    ApplicationArea = All;
                    Caption = 'Pet ID';
                    ToolTip = 'Specifies the ID of the pet.';
                }
                field(FldPetName; PetName)
                {
                    ApplicationArea = All;
                    Caption = 'Pet Name';
                    ToolTip = 'Specifies the name of the pet.';
                }
                field(FldPetStatus; PetStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Pet Status';
                    ToolTip = 'Specifies the status of the pet.';
                }
            }
        }
        area(Factboxes) { }
    }

    actions
    {
        area(Processing)
        {
            action(PetGetAction)
            {
                ApplicationArea = All;
                Caption = 'Get';
                ToolTip = 'Gets the pet with the specified ID.';
                Image = GetOrder;

                trigger OnAction()
                var
                    Client: Codeunit "ApiClient";
                    Pet: Codeunit "Pet";
                begin
                    Pet := Client.Pet().Item_Idx(PetId).Get();
                    SetStatus(Client.Response());
                    if Client.Response().GetIsSuccessStatusCode() then begin
                        PetName := Pet.Name();
                        PetStatus := Pet.Status();
                    end;
                    CompleteResponse := Client.Response().GetContent().AsText();
                end;
            }
            action(SetValueOnUninitializedPet)
            {
                ApplicationArea = All;
                Caption = 'Set Value on Uninitialized Pet';
                ToolTip = 'Just to test manual object creation';
                Image = Action;

                trigger OnAction()
                var
                    Pet: Codeunit "Pet";
                begin
                    Pet.Name('New Pet Name');
                    Pet.Status(Enum::Pet_status::Available);
                    Pet.ToJson().WriteTo(CompleteResponse);
                end;
            }

            action(PostCurrentResponseValue)
            {
                ApplicationArea = All;
                Caption = 'Post Current Response Value';
                ToolTip = 'Post Current Response Value';
                Image = Post;

                trigger OnAction()
                var
                    Client: Codeunit "ApiClient";
                    Config: Codeunit "Kiota ClientConfig SOHH";
                    Pet: Codeunit "Pet";
                begin
                    // get default configuration and add content type header >>
                    Config := Client.Configuration();
                    Config.AddHeader('Content-Type', 'application/json');
                    Client.Configuration(Config);
                    // <<
                    // get current response value, convert to Pet object and post it >>
                    Pet.SetBody(TextToJson(CompleteResponse));
                    Client.Pet().Post(Pet);
                    // <<
                    SetStatus(Client.Response());
                end;
            }
            action(PutCurrentResponseValue)
            {
                ApplicationArea = All;
                Caption = 'Put Current Response Value';
                ToolTip = 'Put Current Response Value';
                Image = Post;

                trigger OnAction()
                var
                    Client: Codeunit "ApiClient";
                    Config: Codeunit "Kiota ClientConfig SOHH";
                    Pet: Codeunit "Pet";
                begin
                    // get default configuration and add content type header >>
                    Config := Client.Configuration();
                    Config.AddHeader('Content-Type', 'application/json');
                    Client.Configuration(Config);
                    // <<
                    // get current response value, convert to Pet object and put it >>
                    Pet.SetBody(TextToJson(CompleteResponse));
                    Client.Pet().Put(Pet);
                    // <<
                    SetStatus(Client.Response());
                end;
            }
            action(ResetAction)
            {
                ApplicationArea = All;
                Caption = 'Reset';
                ToolTip = 'Reset';
                Image = ClearLog;

                trigger OnAction()
                begin
                    Init();
                end;
            }
        }
        area(Promoted)
        {
            actionref(PetGetActionRef; PetGetAction) { }
            actionref(ResetActionRef; ResetAction) { }
        }
    }

    var
        PetName, PhotoUrls, ObjectTags, HttpStatus, CompleteResponse : Text;
        PetStatus: Enum "Pet_status";
        PetId: BigInteger;

    trigger OnOpenPage()
    begin
        Init();
    end;

    local procedure Init()
    begin
        HttpStatus := '<Status>';
        CompleteResponse := '<Response>';
        PetName := '';
        PhotoUrls := '[]';
        ObjectTags := '[]';
        PetId := 999;
    end;

    local procedure SetStatus(Response: Codeunit "Http Response Message")
    begin
        HttpStatus := Format(Response.GetHttpStatusCode()) + ' ' + Response.GetReasonPhrase();
    end;

    local procedure TextToJson(JsonAsTxt: Text) Obj: JsonObject
    begin
        Obj.ReadFrom(JsonAsTxt);
    end;
}