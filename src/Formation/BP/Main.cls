/// 
Class Formation.BP.Main Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Formation.RM.CSV.Record' response='Formation.Msg.FormationInsertResponse' height='2000' width='2000' >
<context>
<property name='tMessageInsert' type='Formation.Msg.FormationInsertRequest' instantiate='0' />
</context>
<sequence xend='200' yend='450' >
<transform name='Utilisation de la transformation' class='Formation.DT.CSVtoInsertMessage' source='request' target='context.tMessageInsert' xpos='200' ypos='250' >
<annotation><![CDATA[Transform avec request (input) et context.tMessageInsert (output)]]></annotation>
</transform>
<call name='Appel InsertBDD' target='LocalBDD' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[Appel Operation LocalBDD avec le message formation InsertRequest
callrequest (input) et response (output)]]></annotation>
<request type='Formation.Msg.FormationInsertRequest' >
<assign property="callrequest" value="context.tMessageInsert" action="set" />
</request>
<response type='Formation.Msg.FormationInsertResponse' >
<assign property="response.Status" value="callresponse.Status" action="set" />
</response>
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
