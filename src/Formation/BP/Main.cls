/// 
Class Formation.BP.Main Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Formation.RM.CSV.Record' response='Formation.Msg.FormationInsertResponse' height='2000' width='2000' >
<context>
<property name='tMessageInsertToAllBDD' type='Formation.Msg.FormationInsertRequest' instantiate='0' >
<annotation><![CDATA[ligne à insérer (obj)]]></annotation>
</property>
</context>
<sequence xend='200' yend='650' >
<trace name='affiche le nom en court' value='"Nom objet en entree de DTL"_request.nom' xpos='200' ypos='250' />
<transform name='Utilisation de la transformation' class='Formation.DT.CSVtoInsertMessage' source='request' target='context.tMessageInsertToAllBDD' xpos='200' ypos='350' >
<annotation><![CDATA[Mapping de la request de la classe Formation.RM.CSV.Record (source) avec obj de la classe Formation.Msg.FormationInsertRequest context.tMessageInsert (cible)]]></annotation>
</transform>
<call name='Appel InsertBDD local' target='LocalBDD' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[Appel Operation LocalBDD avec le message formation InsertRequest
callrequest (input) et response (output)]]></annotation>
<request type='Formation.Msg.FormationInsertRequest' >
<assign property="callrequest" value="context.tMessageInsertToAllBDD" action="set" >
<annotation><![CDATA[Appel du message sorti de la transform]]></annotation>
</assign>
</request>
<response type='Formation.Msg.FormationInsertResponse' >
<assign property="response.Status" value="callresponse.Status" action="set" />
</response>
</call>
<call name='Appel InsertBDD externe' target='RemoteBDD' async='0' xpos='200' ypos='550' >
<annotation><![CDATA[Appel Operation BDD externe avec le message formation InsertRequest
callrequest (input) et response (output)]]></annotation>
<request type='Formation.Msg.FormationInsertRequest' >
<assign property="callrequest" value="context.tMessageInsertToAllBDD" action="set" >
<annotation><![CDATA[Appel du message sorti de la transform]]></annotation>
</assign>
</request>
<response type='Formation.Msg.FormationInsertResponse' >
<assign property="response.Status" value="callresponse.Status" action="set" />
</response>
</call>
</sequence>
</process>
}

}
