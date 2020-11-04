Include EnsSQLTypes

Class Formation.BO.RemoteBDD Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Grongier.SQL.OutboundAdapter";

Property Adapter As Grongier.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method InsertRemoteBDD(pRequest As Formation.Msg.FormationInsertRequest, Output pResponse As Formation.Msg.FormationSelectAllResponse) As %Status
{
	set tStatus = $$$OK
	
	try{
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

Method SelectAllRemoteBDD(pRequest As Formation.Msg.FormationSelectAllRequest, Output pResponse As Formation.Msg.FormationSelectAllResponse) As %Status
{
	// initialisation à OK si erreur autre chase dans le catch
	set tStatus = $$$OK

	try
	{
/// creation de la reponse
	set pResponse = ##class(Formation.Msg.FormationSelectAllResponse).%New()
/// creation de la request
  //ReTypage de l'adaptateur
   //#Dim Adapter As EnsLib.SQL.OutboundAdapter
   // stockage des resultats du select dans tResult et le $$$ThrowOnError permet de capter les erreurs
   set tSelectAllSql = "select * from public.formation"
   $$$ThrowOnError(..Adapter.ExecuteQueryBatch(.tResult,tSelectAllSql,50))
/// parcours des résultats avec la boucle while
   while tResult.%Next()
   {
	   ///$$$TRACE("Id bdd "_tResult.GetData(1))
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
		<Method>SelectAllRemoteBDD</Method>
	</MapItem>
		<MapItem MessageType="Ens.StringRequest"> 
		<Method>SelectByNameRemoteBDD</Method>
	</MapItem>
</MapItems>
}

}
