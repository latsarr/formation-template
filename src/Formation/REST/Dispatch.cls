Class Formation.REST.Dispatch Extends %CSP.REST
{

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 0;

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

/// The default response charset is utf-8
Parameter CHARSET = "utf-8";

Parameter HandleCorsRequest = 1;

// mapper le name space intersystems et le routage

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <!-- import avec appel verbe get-->
  <Route Url="/import" Method="post" Call="import" />
    <!-- export avec appel verbe get -->
  <Route Url="/export" Method="get" Call="export" />
   <Route Url="/exportbyname/:name" Method="get" Call="exportbyname" />
</Routes>
}

/// Get this spec
/// // import vers LocalBDD
ClassMethod import() As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToLocalBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationInsertRequest).%New()
        
        // permet de lire le contenu Message et convertir en utf8
      set body = $zcvt(%request.Content.Read(),"I","UTF8")
      /// creation obj dynamique consommant le body
      set dyna = {}.%FromJSON(body)
      /// construire le messaage json
      set tFormation = ##class(Formation.Obj.Formation).%New()
      set tFormation.Nom = dyna.nom
      set tFormation.Salle = dyna.salle
      set tMsg.Formation = tFormation

      /// envoi du message vers BS tBsName (recup processus dans la prod)
       $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
      // envoi du message dans le service (donc dans la production), tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.ProcessInput(tMsg,.output))

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

// export avec select depuis LocalBDD

ClassMethod export() As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToLocalBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationSelectAllRequest).%New()
        
      /// envoi du message vers BS tBsName (recup processus dans la prod)
       $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
      // envoi le message dans le service (donc dans la production), tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.ExportFromLocalBDD(tMsg,.output))
        // initialise la liste dans laquelle on va stocker les objet jsson
        set dyna = []
        for i =1:1:output.ListeFormation.Count()
        {
          // init objet json
        set tdyna = {}
        set tdyna.nom = output.ListeFormation.GetAt(i).Nom
        set tdyna.salle = output.ListeFormation.GetAt(i).Salle
        // ajoute de chaque object
        do dyna.%Push(tdyna)

        }
        // Conversion en json
      write dyna.%ToJSON()

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

ClassMethod exportbyname(name As %String) As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToLocalBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationSelectByNameRequest).%New()
        set tMsg.Nom = name
        /// envoi du message vers BS tBsName (recup processus dans la prod)
        $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
        // envoi le message dans le BS RestInputToLocalBDD via la methode FromLocalToremoteBDD (donc dans la production ), tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.FromLocalToremoteBDD(tMsg,.output))
         // envoi le message dans le service (donc dans la production), tService est l'instance du service dans la prod
        //$$$ThrowOnError(tService.FromLocalToremoteBDDByLot(tMsg,.output))

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

}
