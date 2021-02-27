Include EnsSQLTypes

Class Formation.BO.RemoteBDD Extends Ens.BusinessOperation
{

/// BO rest sert de publication des api
Parameter ADAPTER = "Grongier.SQL.OutboundAdapter";

Property Adapter As Grongier.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method InsertRemoteBDD(pRequest As Formation.Msg.FormationInsertRequest, Output pResponse As Formation.Msg.FormationSelectAllResponse) As %Status
{
	set tStatus = $$$OK
	
	try{
		$$$LOGINFO("Insertion : "_pRequest.Formation.Nom)
/// creation de la reponse
		set pResponse = ##class(Formation.Msg.FormationInsertResponse).%New()
/// creation de la request
		set ^inc = $I(^inc) // incremation de l'id
		// ? parametres
		set tInsertSql = "INSERT INTO public.formation (id, nom, salle) VALUES(?, ?, ?)"
/// appel methode executeUpdate de la  classe EnsLib.SQL.OutboundAdapter
		$$$ThrowOnError(..Adapter.ExecuteUpdate(.nrows,tInsertSql,^inc,pRequest.Formation.Nom,pRequest.Formation.Salle))
		set pResponse.Status = 1

	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
		set pResponse.Status = 0
	}

	Quit tStatus
}

Method InsertLotToRemoteBDD(pRequest As Formation.Msg.FormationInsertAllRequest, Output pResponse As Formation.Msg.FormationInsertAllResponse) As %Status
{
	set tStatus = $$$OK
	
	try{
					
		set nbLignes = 0
		set pResponse = ##class(Formation.Msg.FormationSelectAllResponse).%New()
		
		set SqlInsertLot = "INSERT into public.formation (id, nom, salle) VALUES(?, ?, ?)"

		$$$LOGINFO(SqlInsertLot)
		
		set batch = 10
				
		set end =""
		set i=1
		while i<pRequest.ListOfAllObjFormation.Count(){
			
			set param = ""
			
			for k=1:1:batch {
				$$$LOGINFO("Affiche i="_i_" Affiche k="_k)	

				set param(k,1) = i
				set param(k,1,"SqlType")=$$$SqlInteger

				set param(k,2) = pRequest.ListOfAllObjFormation.GetAt(i).Nom
				set param(k,2,"SqlType")=$$$SqlVarchar
			
				set param(k,3) = pRequest.ListOfAllObjFormation.GetAt(i).Salle
				set param(k,3,"SqlType")=$$$SqlVarchar
				/// Nombre de parametres
				set param(k) = 3

				set i = i + 1
				q:(i=pRequest.ListOfAllObjFormation.Count())
							
				}	
		     
			set param = k
			
		$$$ThrowOnError(..Adapter.ExecuteUpdateBatchParamArray(.nrows,SqlInsertLot,.param))
			// un . referencement et .. this

			//$$$LOGINFO(sc)	

			k param // kill param
				
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

/// Les methodes suivantes on été créées ici pour des raisons de pb de connexion RemoteDBB
Method SelectAllRemotedBDD(pRequest As Formation.Msg.FormationSelectAllRequest, Output pResponse As Formation.Msg.FormationSelectAllResponse) As %Status
{
	
	// initialisation à OK si erreur autre chase dans le catch
	//$$$LOGINFO("recuperer toute la liste des objets message depuis la base Remote")
	set tStatus = $$$OK
	set pResponse = ##class(Formation.Msg.FormationSelectAllResponse).%New() // ## synthxe pour objectscript pour appeler une classe
	
	set pResponse.ListeFormation = ##class(%Library.ListOfObjects).%New()
	
	try
	{
	set tselectAll = "SELECT * FROM public.formation"
	SET tStatement = ##class(%SQL.Statement).%New()
    SET qStatus = tStatement.%Prepare(tselectAll)
	SET rset = tStatement.%Execute()
	Set objCount = 0
	/// creation d'objet temporaire à peupler
	set tFormation = ##class(Formation.Obj.Formation).%New()
	while rset.%Next(){
	Set objCount = objCount + 1
	set tFormation.Nom = rset.%Get("nom")
	set tFormation.Salle = rset.%Get("salle")
	
	do pResponse.ListeFormation.Insert(tFormation)

	//$$$TRACE("Id "_rset.%Get("ID"))

	}
	$$$TRACE("Nombre Obj selectionne : "_objCount)
	set pResponse.Status = 1
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
		set pResponse.Status = 0
	}
		Quit tStatus
}

Method SelectByNameRemoteBDD(pRequest As Ens.StringRequest, Output pResponse As Formation.Msg.FormationSelectAllResponse) As %Status
{
	set tStatus = $$$OK
	try{
	//set pResponse = ##class(Formation.Msg.FormationSelectResponse).%New()
	///set pResponse.ListFormation = ##class(%Library.ListOfObjects).%New()

	set tSelectSql = "select * from public.formation"
	$$$LOGINFO(tSelectSql)
	$$$ThrowOnError(..Adapter.ExecuteQueryBatch(.tRs,tSelectSql,50))

	While tRs.%Next(){

	set tFormation = ##class(Formation.Obj.Formation).%New()
	set tFormation.Nom = tRs.Get("nom")
	set tFormation.Salle = tRs.Get("salle")
	//$$$ThrowOnError(pResponse.ListFormation.Insert(tFormation))
	}
	}
	catch exp
	{
	Set tStatus = exp.AsStatus()
	}

	Quit tStatus
}

// sert à mapper les message vers les methodes de la classe

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Formation.Msg.FormationInsertRequest"> 
		<Method>InsertRemoteBDD</Method>
	</MapItem>
		<MapItem MessageType="Formation.Msg.FormationSelectAllRequest"> 
		<Method>SelectAllRemotedBDD</Method>
	</MapItem>
		<MapItem MessageType="Ens.StringRequest"> 
		<Method>SelectByNameRemoteBDD</Method>
	</MapItem>
			<MapItem MessageType="Formation.Msg.FormationInsertAllRequest"> 
		<Method>InsertLotToRemoteBDD</Method>
	</MapItem>
</MapItems>
}

}
