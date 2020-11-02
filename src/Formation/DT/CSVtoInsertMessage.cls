Class Formation.DT.CSVtoInsertMessage Extends Ens.DataTransformDTL [ DependsOn = (Formation.RM.CSV.Record, Formation.Msg.FormationInsertRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Formation.RM.CSV.Record' targetClass='Formation.Msg.FormationInsertRequest' create='new' language='objectscript' >
<assign value='source.nom' property='target.Formation.Nom' action='set' />
<assign value='source.salle' property='target.Formation.Salle' action='set' />
</transform>
}

}
