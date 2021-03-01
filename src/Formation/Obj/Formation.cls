/// Construction d'object à utiliser dans les messgae. Il herite de methode %XML.Adaptor permettant projection (affichage) en xml dans le portal management
/// %SerialObject sert a purger l'objet lorsque le message est purge
Class Formation.Obj.Formation Extends (%SerialObject, %XML.Adaptor)
{

Property Nom As %String;

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
