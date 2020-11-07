/// 
Class Formation.BP.Batch Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Formation.RM.CSV.Batch' response='Formation.Msg.FormationInsertResponse' height='2000' width='2000' >
<context>
<property name='key' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='CompteurErreur' type='%Integer' initialexpression='0' instantiate='0' >
<annotation><![CDATA[Compteur dinsert KO]]></annotation>
</property>
</context>
<sequence xend='200' yend='900' >
<trace name='Lecture batch en une fois' value='request.%Source' xpos='200' ypos='250' />
<foreach name='Pour chaque record' property='request.Records' key='context.key' xpos='200' ypos='350' xend='200' yend='700' >
<annotation><![CDATA[boucle foreach pour parcourir toute l'enregistrement]]></annotation>
<scope xpos='200' ypos='250' xend='200' yend='600' >
<call name='appel BP Main' target='Main' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[callrequest (input) correspond au contenu de chaque ligne et response (output) ]]></annotation>
<request type='Formation.RM.CSV.Record' >
<assign property="callrequest" value="request.Records.GetAt(context.key)" action="set" />
</request>
<response type='Formation.Msg.FormationInsertResponse' >
<assign property="response.Status" value="callresponse.Status" action="set" />
</response>
</call>
<faulthandlers>
<catchall xpos='200' ypos='450' xend='200' yend='350' >
<assign name="increment de Compteur Erreur" property="context.CompteurErreur" value="context.CompteurErreur + 1" action="set" xpos='200' ypos='250' />
</catchall>
</faulthandlers>
</scope>
</foreach>
<if name='test sur  compteur erreur' condition='context.CompteurErreur &apos;=0' xpos='200' ypos='450' xend='200' yend='700' >
<annotation><![CDATA[si CompteurErreur = 0 tous les insert sont OK
sinon KO]]></annotation>
<true>
<assign property="response.Status" value="0" action="set" xpos='470' ypos='600' />
</true>
<false>
<assign property="response.Status" value="1" action="set" xpos='200' ypos='600' />
</false>
</if>
<trace name='valeur du compteur Erreur' value='context.CompteurErreur' xpos='200' ypos='800' >
<annotation><![CDATA[affiche la valeur du compteur]]></annotation>
</trace>
</sequence>
</process>
}

}
