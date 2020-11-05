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

// sert à mapper les message vers les methodes de la classe

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Formation.Msg.FormationInsertRequest"> 
		<Method>InsertRemoteBDD</Method>
	</MapItem>
		<MapItem MessageType="Formation.Msg.FormationInsertAllRequest"> 
		<Method>InsertLotToRemoteBDD</Method>
	</MapItem>
</MapItems>
}

}
