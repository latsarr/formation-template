Class Formation.Msg.FormationSelectAllResponse Extends Ens.Response
{

// renvoie un status boolean

Property ListeFormation As list Of Formation.Obj.Formation;

Property Status As %Boolean;

Storage Default
{
<Data name="FormationSelectAllResponseDefaultData">
<Subscript>"FormationSelectAllResponse"</Subscript>
<Value name="1">
<Value>Status</Value>
</Value>
<Value name="2">
<Value>ListeFormation</Value>
</Value>
</Data>
<DefaultData>FormationSelectAllResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
