/// 
Class Formation.BP.Batch Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Formation.RM.CSV.Batch' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='key' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='350' >
<foreach name='Pour chaque record' property='request.Records' key='context.key' xpos='200' ypos='250' xend='200' yend='450' >
<trace name='Trace key' value='context.key' xpos='200' ypos='250' />
<call name='appel BP Main' target='Main' async='0' xpos='200' ypos='350' >
<request type='Formation.RM.CSV.Record' >
<assign property="callrequest" value="request.Records.GetAt(context.key)" action="set" />
</request>
<response type='Ens.Response' />
</call>
</foreach>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
