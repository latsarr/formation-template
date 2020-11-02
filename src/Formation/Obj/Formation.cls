/// Construction d'object à utiliser dans les messgae. Il herite de methode pertant projection (affichage) en xml
Class Formation.Obj.Formation Extends (%SerialObject, %XML.Adaptor)
{

Property Nom As %String;

Property Prenom As %String;

Property Salle As %String;

Storage Default
{
<Data name="FormationState">
<Value name="1">
<Value>Nom</Value>
</Value>
<Value name="2">
<Value>Salle</Value>
</Value>
<Value name="3">
<Value>Prenom</Value>
</Value>
</Data>
<State>FormationState</State>
<StreamLocation>^Formation.Obj.FormationS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
