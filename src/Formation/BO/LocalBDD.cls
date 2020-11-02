Class Formation.BO.LocalBDD Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

// instancier les operations avec une gestion en file d'attente 

Method InsertLocalBDD(pRequest As Formation.Msg.FormationInsertRequest, Output pResponse As Ens.StringResponse) As %Status
{
	set tStatus = $$$OK // convention de nommage le t pour variable temporaire, p parametre
	
	try{
		set pResponse = ##class(Ens.Response).%New() // ## synthxe pour objectscript pour appeler une classe
        set tFormation = ##class(Formation.Table.Formation).%New() // % convention de logic system
        set tFormation.Name = pRequest.Formation.Nom
        set tFormation.Salle = pRequest.Formation.Salle
        $$$ThrowOnError(tFormation.%Save())
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
	}

	Quit tStatus
}

// sert à mapper le message vers la méthode

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Formation.Msg.FormationInsertRequest"> 
		<Method>InsertLocalBDD</Method>
	</MapItem>
</MapItems>
}

}
