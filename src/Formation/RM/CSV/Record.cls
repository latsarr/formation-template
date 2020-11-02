/// RECORDMAP: Generated from RecordMap 'Formation.RM.CSV'
/// on 2020-11-02 at 15:14:08.748 [2020-11-02 15:14:08.748 UTC]
/// by user SuperUser
Class Formation.RM.CSV.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property id As %String [ SqlColumnNumber = 2 ];

Property nom As %String [ SqlColumnNumber = 3 ];

Property salle As %String [ SqlColumnNumber = 4 ];

Parameter RECORDMAPGENERATED = 1;

Relationship %ParentBatch As Formation.RM.CSV.Batch [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>id</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>salle</Value>
</Value>
<Value name="5">
<Value>nom</Value>
</Value>
<Value name="6">
<Value>%ParentBatch</Value>
</Value>
</Data>
<DataLocation>^Formation.RM.CSV.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^Formation.RM.CSV.RecordD</IdLocation>
<IndexLocation>^Formation.RM.CSV.RecordI</IndexLocation>
<StreamLocation>^Formation.RM.CSV.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
