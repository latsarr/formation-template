Class Formation.Msg.FormationInsertAllResponse Extends Ens.Response
{

// renvoie un status boolean

Property Status As %Boolean;

Storage Default
{
<Data name="FormationInsertResponseDefaultData">
<Subscript>"FormationInsertResponse"</Subscript>
<Value name="1">
<Value>Status</Value>
</Value>
</Data>
<DefaultData>FormationInsertResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
