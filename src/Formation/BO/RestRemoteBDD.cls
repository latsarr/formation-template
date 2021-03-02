Class Formation.BO.RestRemoteBDD Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

Method InsertRemoteBDD(pRequest As Formation.Msg.FormationSelectAllRequest, Output pResponse As Formation.Msg.FormationSelectAllResponse) As %Status
{
	set tStatus = $$$OK
	
   try {
      // Prepare and log the call
      // Get the URL configured for adapter
      Set tURL=..Adapter.URL
      $$$LOGINFO(tURL)
      // Execute the call
      // Set tSC=..Adapter.GetURL(tURL,.tHttpResponse)
	
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
	<MapItem MessageType="Formation.Msg.FormationSelectAllRequest"> 
		<Method>InsertRemoteBDD</Method>
	</MapItem>
</MapItems>
}

}
