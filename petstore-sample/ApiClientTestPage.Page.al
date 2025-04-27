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
                field(FldStatus; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Specifies the status of the request.';
                }
                field(FldPetName; GlobalString)
                {
                    ApplicationArea = All;
                    Caption = 'Pet Name';
                    ToolTip = 'Specifies the name of the pet.';
                }
                field(FldPetID; PetId)
                {
                    ApplicationArea = All;
                    Caption = 'Pet ID';
                    ToolTip = 'Specifies the ID of the pet.';
                }
                field(FldCompleteResponse; CompleteResponse)
                {
                    ApplicationArea = All;
                    Caption = 'Complete Response';
                    ToolTip = 'Specifies the complete response from the API.';
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
            action(PetGetAction)
            {
                ApplicationArea = All;
                Caption = 'Pet Get';
                ToolTip = 'Pet Get';
                Image = GetOrder;

                trigger OnAction()
                var
                    Client: Codeunit "ApiClient";
                    Pet: Codeunit "Pet";
                begin
                    Status := '';
                    CompleteResponse := '';
                    Pet := Client.Pet().Item_Idx(PetId).Get();
                    if Client.Response().GetIsSuccessStatusCode() then begin
                        Status := 'Success';
                        GlobalString := Pet.Name();
                    end else
                        Status := 'Error';
                    CompleteResponse := Client.Response().GetContent().AsText();
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
        GlobalString, Status, CompleteResponse : Text;
        PetId: BigInteger;

    trigger OnOpenPage()
    begin
        Init();
    end;

    local procedure Init()
    begin
        Status := '<Status>';
        CompleteResponse := '<Response>';
        GlobalString := '<Name>';
        PetId := 999;
    end;
}