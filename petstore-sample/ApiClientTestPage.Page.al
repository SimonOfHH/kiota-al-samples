page 50000 ApiClientTestPage
{
    Caption = 'API Client Test Page';
    DataCaptionExpression = '';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Integer;

    layout
    {
        area(Content)
        {

            group(PetFields)
            {
                Caption = 'Pet';
                field(FldPetID; PetId)
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    ToolTip = 'Specifies the ID of the pet.';
                    Editable = true;
                }
                field(FldPetName; PetName)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Specifies the name of the pet.';
                }
                field(FldPetStatus; PetStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Specifies the status of the pet.';
                    Editable = true;
                }
                field(FldPhotoUrls; PetPhotoUrls)
                {
                    ApplicationArea = All;
                    Caption = 'Photo URLs';
                    ToolTip = 'Specifies the photo URLs of the pet.';
                    Multiline = true;
                }
                field(FldObjectTags; PetTags)
                {
                    ApplicationArea = All;
                    Caption = 'Tags';
                    ToolTip = 'Specifies the tags of the pet.';
                    Multiline = true;
                }
            }
            group(Response)
            {
                field(FldHttpStatus; HttpStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Specifies the status of the request.';
                }
                field(FldCompleteResponse; CompleteResponse)
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    ToolTip = 'The response from the API.';
                    Multiline = true;
                }
            }
        }
        area(Factboxes) { }
    }

    actions
    {
        area(Processing)
        {
            group(PetActions)
            {
                Caption = 'Pet';
                action(PetGetAction)
                {
                    ApplicationArea = All;
                    Caption = 'Get';
                    ToolTip = 'Gets the pet with the specified ID.';
                    Image = GetOrder;

                    trigger OnAction()
                    var
                        Client: Codeunit "ApiClient";
                    begin
                        PetObject := Client.Pet().Item_Idx(PetId).Get();
                        SetStatusAndResponseContent(Client.Response());
                        if Client.Response().GetIsSuccessStatusCode() then
                            ObjectToVariables();
                    end;
                }
                action(PetPutAction)
                {
                    ApplicationArea = All;
                    Caption = 'Put';
                    ToolTip = 'Put Current Response Value';
                    Image = Post;

                    trigger OnAction()
                    var
                        Client: Codeunit "ApiClient";
                        Config: Codeunit "Kiota ClientConfig SOHH";
                    begin
                        // get default configuration and add content type header >>
                        Config := Client.Configuration();
                        Config.AddHeader('Content-Type', 'application/json');
                        Client.Configuration(Config);
                        // <<

                        VariablesToObject();
                        PetObject := Client.Pet().Put(PetObject);

                        if Client.Response().GetIsSuccessStatusCode() then
                            ObjectToVariables();
                        SetStatusAndResponseContent(Client.Response());
                    end;
                }
                action(PetPostAction)
                {
                    ApplicationArea = All;
                    Caption = 'Post';
                    ToolTip = 'Post Current Response Value';
                    Image = Post;

                    trigger OnAction()
                    var
                        Client: Codeunit "ApiClient";
                        Config: Codeunit "Kiota ClientConfig SOHH";
                    begin
                        // get default configuration and add content type header >>
                        Config := Client.Configuration();
                        Config.AddHeader('Content-Type', 'application/json');
                        Client.Configuration(Config);
                        // <<

                        VariablesToObject();
                        PetObject := Client.Pet().Post(PetObject);

                        if Client.Response().GetIsSuccessStatusCode() then
                            ObjectToVariables();
                        SetStatusAndResponseContent(Client.Response());
                    end;
                }
                action(PetPostImage)
                {
                    ApplicationArea = All;
                    Caption = 'Post Image';
                    ToolTip = 'Post Image';
                    Image = Post;

                    trigger OnAction()
                    var
                        Client: Codeunit "ApiClient";
                        Config: Codeunit "Kiota ClientConfig SOHH";
                        Content: HttpContent;
                    begin
                        // get default configuration and add content type header >>
                        Config := Client.Configuration();
                        Config.AddHeader('Content-Type', 'application/octet-stream');
                        Client.Configuration(Config);
                        // <<

                        if not PictureToHttpContent(Content) then
                            exit;

                        Client.Pet().Item_Idx(PetId).UploadImage().Post(Content, '');

                        if Client.Response().GetIsSuccessStatusCode() then
                            ObjectToVariables();
                        SetStatusAndResponseContent(Client.Response());
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
        }
        area(Promoted)
        {
            group(PetActionsPromoted)
            {
                Caption = 'Pet';
                ShowAs = SplitButton;
                Image = Web;
                actionref(PetGetActionRef; PetGetAction) { }
                actionref(PetPutActionRef; PetPutAction) { }
                actionref(PetPostActionRef; PetPostAction) { }
                actionref(PetPostImageRef; PetPostImage) { }
            }

            actionref(ResetActionRef; ResetAction) { }
        }
    }

    var
        PetObject: Codeunit "Pet";
        PetName, PetPhotoUrls, PetTags, HttpStatus, CompleteResponse : Text;
        PetStatus: Enum "Pet_status";
        PetId: BigInteger;

    trigger OnOpenPage()
    begin
        Init();
    end;

    local procedure VariablesToObject()
    begin
        Clear(PetObject);
        PetObject.Id(PetId);
        PetObject.Name(PetName);
        PetObject.PhotoUrls(PetPhotoUrls.Split(','));
        PetObject.Tags(TagStringListToList(PetTags));
        PetObject.Status(PetStatus);
    end;

    local procedure ObjectToVariables()
    begin
        PetId := PetObject.Id();
        PetName := PetObject.Name();
        PetPhotoUrls := JoinList(PetObject.PhotoUrls());
        PetTags := JoinList(PetObject.Tags());
        PetStatus := PetObject.Status();
    end;

    local procedure Init()
    begin
        HttpStatus := '<Status>';
        CompleteResponse := '<Response>';
        PetName := '';
        PetPhotoUrls := '[]';
        PetTags := '[]';
        PetStatus := Enum::Pet_status::Available;
        PetId := 999;
    end;

    local procedure SetStatusAndResponseContent(ApiResponse: Codeunit "Http Response Message")
    begin
        HttpStatus := Format(ApiResponse.GetHttpStatusCode()) + ' ' + ApiResponse.GetReasonPhrase();
        CompleteResponse := ApiResponse.GetContent().AsText();
    end;

    local procedure JoinList(List: List of [Text]) Result: Text
    var
        Item: Text;
    begin
        Result := '';
        foreach Item in List do begin
            if Result <> '' then
                Result += ',';
            Result += Item;
        end;
        exit(Result);
    end;

    local procedure JoinList(List: List of [Codeunit Tag]) Result: Text
    var
        Item: Codeunit Tag;
        ValuesLbl: Label '(%1: %2)', Locked = true;
    begin
        Result := '';
        foreach Item in List do begin
            if Result <> '' then
                Result += ',';
            Result += StrSubstNo(ValuesLbl, Item.Id(), Item.Name());
        end;
        exit(Result);
    end;

    local procedure TagStringListToList(PetTagsParam: Text): List of [Codeunit Tag]
    var
        TagObject: Codeunit Tag;
        NewPetTags: List of [Codeunit Tag];
        StringList: List of [Text];
        TempValues: List of [Text];
        ListEntry: Text;
        Id: BigInteger;
    begin
        if PetTagsParam = '' then
            exit(NewPetTags);
        StringList := PetTagsParam.Split(',');
        foreach ListEntry in StringList do begin
            ListEntry := ListEntry.Replace('(', '');
            ListEntry := ListEntry.Replace(')', '');
            TempValues := ListEntry.Split(':');
            Evaluate(Id, TempValues.Get(1).Trim());
            Clear(TagObject);
            TagObject.Id(Id);
            TagObject.Name(TempValues.Get(2).Trim());
            NewPetTags.Add(TagObject);
        end;
        exit(NewPetTags);
    end;

    local procedure PictureToHttpContent(var Content: HttpContent): Boolean
    var
        InStream: InStream;
    begin
        if not UploadIntoStream('', InStream) then exit(false);
        Content.WriteFrom(InStream);
        exit(true);
    end;
}