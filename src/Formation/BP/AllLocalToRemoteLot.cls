/// 
Class Formation.BP.AllLocalToRemoteLot Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Formation.Msg.FormationSelectAllRequest' response='Formation.Msg.FormationSelectAllResponse' height='2000' width='2000' >
<context>
<property name='key' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='tListFormation' type='Formation.Obj.Formation' collection='list' instantiate='0' />
</context>
<sequence xend='200' yend='450' >
<call name='appel local bdd' target='LocalBDD' async='0' xpos='200' ypos='250' >
<request type='Formation.Msg.FormationSelectAllRequest' />
<response type='Formation.Msg.FormationSelectAllResponse' >
<assign property="context.tListFormation" value="callresponse.ListeFormation" action="set" />
</response>
</call>
<call name='Appel InsertBDD externe par lot' target='RemoteBDD' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[Insertion de la valeur courante context.tCurrentFormation à la bdd externe]]></annotation>
<request type='Formation.Msg.FormationInsertAllRequest' >
<assign property="callrequest.ListOfAllObjFormation" value="context.tListFormation" action="set" />
</request>
<response type='Formation.Msg.FormationInsertResponse' >
<assign property="response.Status" value="callresponse.Status" action="set" />
</response>
</call>
</sequence>
</process>
}

}
