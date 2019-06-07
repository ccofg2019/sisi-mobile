unit UnitFormatCNPJCPF;

interface

implementation

uses System.Bindings.Methods,
     System.Bindings.EvalProtocol,
     System.Bindings.Consts,
     System.TypInfo,
     System.SysUtils,
     System.MaskUtils;

function MakeMethodFormatarCNPJCPF: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    InputValue: IValue;
    InputString : String;
    OutputString: String;
  begin

    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sFormatArgError);


    InputValue := Args[0];
    //if not (InputValue.GetType.Kind in [tkFloat]) then
    //  raise EEvaluatorError.Create(sFormatExpectedStr);

    // Calculate the output integer.
    InputString := InputValue.GetValue().AsString;
    if Length(InputString) > 11 then
    begin
      OutputString := FormatMaskText('00\.000\.000\/0000\-00;0', InputString);
    end
    else
    begin
       OutputString := FormatMaskText('000\.000\.000\-00;0', InputString);
    end;


    // Return the output integer.
    Result := TValueWrapper.Create(OutputString);
  end);
end;

initialization

  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodFormatarCNPJCPF,
      'FormatarCNPJCPF',
      'FormatarCNPJCPF', '', True,
      sFormatDesc,
      nil));

finalization

  TBindingMethodsFactory.UnRegisterMethod('FormatarCNPJCPF');

end.
