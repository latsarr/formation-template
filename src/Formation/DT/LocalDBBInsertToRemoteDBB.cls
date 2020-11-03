Class Formation.DT.LocalDBBInsertToRemoteDBB Extends Ens.DataTransformDTL [ DependsOn = (Formation.Msg.FormationSelectByNameResponse, Formation.Msg.FormationInsertRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Formation.Msg.FormationSelectByNameResponse' targetClass='Formation.Msg.FormationInsertRequest' create='new' language='objectscript' >
<foreach property='source.ListeFormation()' key='k1' >
<assign value='source.ListeFormation.(k1).Nom' property='target.Formation.Nom' action='set' />
<assign value='source.ListeFormation.(k1).Salle' property='target.Formation.Salle' action='set' />
</foreach>
</transform>
}

}
