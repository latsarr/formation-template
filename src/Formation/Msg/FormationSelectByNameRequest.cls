Class Formation.Msg.FormationSelectByNameRequest Extends Ens.Request
{

Property Nom As %String;

Storage Default
{
<Data name="FormationSelectByNameRequestDefaultData">
<Subscript>"FormationSelectByNameRequest"</Subscript>
<Value name="1">
<Value>ListeFormation</Value>
</Value>
<Value name="2">
<Value>Nom</Value>
</Value>
</Data>
<DefaultData>FormationSelectByNameRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
