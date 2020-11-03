Class Formation.Msg.FormationSelectByNameResponse Extends Ens.Response
{

Property ListeFormation As list Of Formation.Obj.Formation;

Property Status As %Boolean;

Storage Default
{
<Data name="FormationSelectByNameResponseDefaultData">
<Subscript>"FormationSelectByNameResponse"</Subscript>
<Value name="1">
<Value>ListeFormation</Value>
</Value>
<Value name="2">
<Value>Status</Value>
</Value>
</Data>
<DefaultData>FormationSelectByNameResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
