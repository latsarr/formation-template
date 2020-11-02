/// 
Class Formation.BP.Main Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Formation.RM.CSV.Record' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='tMessageInsert' type='Formation.Msg.FormationInsertRequest' instantiate='0' />
</context>
<sequence xend='200' yend='450' >
<transform name='Utilisation de la transformation' class='Formation.DT.CSVtoInsertMessage' source='request' target='context.tMessageInsert' xpos='200' ypos='250' />
<call name='Appel InsertBDD' target='LocalBDD' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[Appel Operation LocalBDD avec le message formation InsertRequest]]></annotation>
<request type='Formation.Msg.FormationInsertRequest' >
<assign property="callrequest" value="context.tMessageInsert" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
