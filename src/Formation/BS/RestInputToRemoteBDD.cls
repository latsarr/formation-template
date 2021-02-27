Class Formation.BS.RestInputToRemoteBDD Extends Ens.BusinessService
{

Property TargetConfigNames As %String(MAXLEN = 1000) [ InitialExpression = "BuisnessProcess" ];

Parameter SETTINGS = "TargetConfigNames:Basic:selector?multiSelect=1&context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId}";

Method OnProcessInput(pDocIn As %RegisteredObject, Output pDocOut As %RegisteredObject) As %Status
{
    set status = $$$OK

    //$$$LOGINFO("Envoi du message dans la production")

    try {

        for iTarget=1:1:$L(..TargetConfigNames, ",") {
		    set tOneTarget=$ZStrip($P(..TargetConfigNames,",",iTarget),"<>W")  Continue:""=tOneTarget
		    // appel BO par rapport à la config du BS dans dans la prod (LocalBDD)
            $$$ThrowOnError(..SendRequestSync(tOneTarget,pDocIn,.pDocOut))
	    }
    } catch ex {
        set status = ex.AsStatus()
    }

    Quit status
}

Method ExportAllFromRemoteBDD(pRequest As Formation.Msg.FormationSelectAllRequest, Output pResponse As Formation.Msg.FormationSelectByNameResponse) As %Status
{
    Quit ..OnProcessInput(pRequest,.pResponse)
}

}
