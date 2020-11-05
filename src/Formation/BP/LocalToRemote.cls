/// 
Class Formation.BP.LocalToRemote Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Formation.Msg.FormationSelectByNameRequest' response='Formation.Msg.FormationSelectByNameResponse' height='2000' width='2000' >
<context>
<property name='key' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='tMessageInsertToRemoteBDD' type='Formation.Obj.Formation' instantiate='0' />
<property name='tListFormation' type='Formation.Obj.Formation' collection='list' instantiate='0' />
<property name='tCurrentFormation' type='Formation.Obj.Formation' instantiate='0' />
</context>
<sequence xend='200' yend='550' >
<trace name='Nom de objet entrant dans le BP' value='request.%ClassName(1)' xpos='200' ypos='250' />
<call name='appel local bdd' target='LocalBDD' async='0' xpos='200' ypos='350' >
<request type='Formation.Msg.FormationSelectByNameRequest' >
<assign property="callrequest.Nom" value="request.Nom" action="set" />
</request>
<response type='Formation.Msg.FormationSelectByNameResponse' >
<assign property="context.tListFormation" value="callresponse.ListeFormation" action="set" />
</response>
</call>
<foreach name='pour chaque ligne' property='context.tListFormation' key='context.key' xpos='200' ypos='450' xend='200' yend='650' >
<annotation><![CDATA[Parcours de la liste context.tListFormation (issue de la requette selectbyname)]]></annotation>
<assign name="affectation formation en cours" property="context.tCurrentFormation" value="context.tListFormation.GetAt(context.key)" action="set" xpos='200' ypos='250' >
<annotation><![CDATA[Affectation de la valeur courante de la liste au context.tCurrentFormation]]></annotation>
</assign>
<transform name='transfo' class='Formation.DT.LocalDBBInsertToRemoteDBB' source='context.tCurrentFormation' target='context.tMessageInsertToRemoteBDD' xpos='200' ypos='350' >
<annotation><![CDATA[transforme le la valeur courante context.tCurrentFormation pour insersion à la cible]]></annotation>
</transform>
<trace value='"Objet courant "_context.tMessageInsertToRemoteBDD.Nom' xpos='200' ypos='450' >
<annotation><![CDATA[affichage obj]]></annotation>
</trace>
<call name='Appel InsertBDD externe' target='RemoteBDD' async='0' xpos='200' ypos='550' >
<annotation><![CDATA[Insertion de la valeur courante context.tCurrentFormation à la bdd externe]]></annotation>
<request type='Formation.Msg.FormationInsertRequest' >
<assign property="callrequest.Formation" value="context.tMessageInsertToRemoteBDD" action="set" />
</request>
<response type='Formation.Msg.FormationInsertResponse' >
<assign property="response.Status" value="callresponse.Status" action="set" />
</response>
</call>
</foreach>
</sequence>
</process>
}

}
