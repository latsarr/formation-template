Class Formation.DT.LocalDBBInsertToRemoteDBB Extends Ens.DataTransformDTL [ DependsOn = Formation.Obj.Formation ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Formation.Obj.Formation' targetClass='Formation.Obj.Formation' create='new' language='objectscript' >
<assign value='source.Nom' property='target.Nom' action='set' />
<assign value='source.Salle' property='target.Salle' action='set' />
</transform>
}

}
