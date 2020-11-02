Class Formation.BO.LocalBDD Extends Ens.BusinessOperation
{

// instancier les operations avec une gestion en file d'attente 

Parameter INVOCATION = "Queue";

// Output signale que la response sera valué en sortie

Method InsertLocalBDD(pRequest As Formation.Msg.FormationInsertRequest, Output pResponse As Formation.Msg.FormationInsertResponse) As %Status
{
	// convention de nommage le t pour variable temporaire, p parametre
	set tStatus = $$$OK 
	
	try{
		set pResponse = ##class(Formation.Msg.FormationInsertResponse).%New() // ## synthxe pour objectscript pour appeler une classe
        
		set tFormation = ##class(Formation.Table.Formation).%New() // % convention de logic system
        set tFormation.Name = pRequest.Formation.Nom
		set tFormation.LastName = pRequest.Formation.Prenom
        set tFormation.Salle = pRequest.Formation.Salle
        $$$ThrowOnError(tFormation.%Save())
		
		set pResponse.Status = 1
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
		set pResponse.Status = 0
	}

	Quit tStatus
}

// sert à mapper le message vers la méthode InsertLocalBDD

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Formation.Msg.FormationInsertRequest"> 
		<Method>InsertLocalBDD</Method>
	</MapItem>
</MapItems>
}

}
