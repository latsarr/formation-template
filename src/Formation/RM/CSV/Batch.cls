/// RECORDMAP: Modified during compilation of RecordMap 'Formation.RM.CSV'
/// on 2020-11-02 at 15:14:08.862 [2020-11-02 15:14:08.862 UTC]
/// by user SuperUser
Class Formation.RM.CSV.Batch Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "Formation_RM_CSV_Batch";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader = "id;nom;salle";

Parameter HeaderTerm = "\x0d\x0a";

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 1;

Relationship Records As Formation.RM.CSV.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "Formation_RM_CSV_Batch";

Storage Default
{
<Data name="BatchDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>%Source</Value>
</Value>
<Value name="3">
<Value>BatchHeader</Value>
</Value>
<Value name="4">
<Value>BatchTrailer</Value>
</Value>
</Data>
<DataLocation>^Formation.RM.CSV.BatchD</DataLocation>
<DefaultData>BatchDefaultData</DefaultData>
<IdLocation>^Formation.RM.CSV.BatchD</IdLocation>
<IndexLocation>^Formation.RM.CSV.BatchI</IndexLocation>
<StreamLocation>^Formation.RM.CSV.BatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
