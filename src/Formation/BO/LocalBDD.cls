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

/// Les methodes suivantes on été créées ici pour des raisons de pb de connexion RemoteDBB
Method SelectAllLocalBDD(pRequest As Formation.Msg.FormationSelectAllRequest, Output pResponse As Formation.Msg.FormationSelectAllResponse) As %Status
{
	// initialisation à OK si erreur autre chase dans le catch
	set tStatus = $$$OK
	set pResponse = ##class(Formation.Msg.FormationSelectAllResponse).%New() // ## synthxe pour objectscript pour appeler une classe
	
	set pResponse.ListeFormation = ##class(%Library.ListOfObjects).%New()
	
	try
	{
	set tselectAll = "SELECT * FROM Formation.Table.Formation"
	SET tStatement = ##class(%SQL.Statement).%New()
    SET qStatus = tStatement.%Prepare(tselectAll)
	SET rset = tStatement.%Execute()
	$$$TRACE("Nombre Obj selectionne "_rset.%Next())
	while rset.%Next(){
/// creation d'objet temporaire à peupler
	set tFormation = ##class(Formation.Obj.Formation).%New()
	set tFormation.Nom = rset.%Get("Name")
	set tFormation.Salle = rset.%Get("Salle")

	do pResponse.ListeFormation.Insert(tFormation)

		$$$TRACE("Id "_rset.%Get("ID"))

	}
		$$$TRACE("Nombre Obj selectionne "_rset.%Next())


		set pResponse.Status = 1
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
		set pResponse.Status = 0
	}
		Quit tStatus
}

Method SelectByNameLocalBDD(pRequest As Formation.Msg.FormationSelectByNameRequest, Output pResponse As Formation.Msg.FormationSelectByNameResponse) As %Status
{
	// initialisation à OK si erreur autre chase dans le catch
	set tStatus = $$$OK

	set pResponse = ##class(Formation.Msg.FormationSelectByNameResponse).%New() // ## synthxe pour objectscript pour appeler une classe
	
	set pResponse.ListeFormation = ##class(%Library.ListOfObjects).%New()
	
	
	try
	{
		// faille de securite (car le parametre concater va permettre d'injecter autre chose comme un drop) --> a optimiser
	set tselectByName= "SELECT * FROM Formation_Table.Formation where Name='"_pRequest.Nom_"'"
	SET tStatement = ##class(%SQL.Statement).%New()
    SET qStatus = tStatement.%Prepare(tselectByName)
	SET rset = tStatement.%Execute()
	while rset.%Next(){
/// creation d'objet temporaire à peupler
	set tFormation = ##class(Formation.Obj.Formation).%New()
	set tFormation.Nom = rset.%Get("Name")
	set tFormation.Salle = rset.%Get("Salle")

	do pResponse.ListeFormation.Insert(tFormation)

		$$$TRACE("Id "_rset.%Get("ID"))
		$$$TRACE("Name "_rset.%Get("Name"))
	}

		set pResponse.Status = 1
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
		set pResponse.Status = 0
	}
		Quit tStatus
}

// sert à mapper le message vers les méthode InsertLocalBDD, SelectAllLocalBDD SelectByNameLocalBDD

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Formation.Msg.FormationInsertRequest"> 
		<Method>InsertLocalBDD</Method>
	</MapItem>
		<MapItem MessageType="Formation.Msg.FormationSelectAllRequest"> 
		<Method>SelectAllLocalBDD</Method>
	</MapItem>
		<MapItem MessageType="Formation.Msg.FormationSelectByNameRequest"> 
		<Method>SelectByNameLocalBDD</Method>
	</MapItem>
	
</MapItems>
}

}
