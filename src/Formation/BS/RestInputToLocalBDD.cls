Class Formation.BS.RestInputToLocalBDD Extends Ens.BusinessService
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

Method ExportAllFromLocalBDD(pRequest As Formation.Msg.FormationSelectAllRequest, Output pResponse As Formation.Msg.FormationSelectByNameResponse) As %Status
{
    Quit ..OnProcessInput(pRequest,.pResponse)
}

Method ExportByNameFromLocalBDD(pRequest As Formation.Msg.FormationSelectByNameRequest, Output pResponse As Formation.Msg.FormationSelectByNameResponse) As %Status
{
    Quit ..OnProcessInput(pRequest,.pResponse)
}

Method FromLocalToremoteBDD(pRequest As Formation.Msg.FormationSelectByNameRequest, Output pResponse As Formation.Msg.FormationSelectByNameResponse) As %Status
{
        set status = $$$OK
        // appel du BP LocalToRemote en dur avec le message
        set tBpNameEnDur = "LocalToRemote"
		$$$ThrowOnError(..SendRequestSync(tBpNameEnDur,pRequest,.pResponse))
        Quit status
}

/*
Method FromLocalToremoteBDDByLot(pRequest As Formation.Msg.FormationSelectByNameRequest, Output pResponse As Formation.Msg.FormationSelectByNameResponse) As %Status
{
        set status = $$$OK
        // appel du BP LocalToRemoteLot en dur avec le message
		$$$ThrowOnError(..SendRequestSync("LocalToRemoteLot",pRequest,.pResponse))
        Quit status
}
*/
}
