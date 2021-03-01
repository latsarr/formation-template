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
  <Route Url="/importlocal" Method="post" Call="importLocalObjet" />
   <Route Url="/importremote" Method="post" Call="importRemoteObjet" />
    <!-- export avec appel verbe get -->
  <Route Url="/exportlo" Method="get" Call="exportAllFromLocal" />
  <Route Url="/exportre" Method="get" Call="exportAllFromRemote" />
    <Route Url="/exportlo/:name" Method="get" Call="exportByNameFromLocal" />
   <Route Url="/exportimport/:name" Method="get" Call="exportLocalImportRemoteByname" />
   <Route Url="/exportimport" Method="get" Call="exportLocalImportRemoteAll" />
</Routes>
}

/// Get this spec
/// // import vers LocalBDD
ClassMethod importLocalObjet() As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToLocalBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationInsertRequest).%New()
        
        // permet de lire le contenu Message et convertir en utf8
      set body = $zcvt(%request.Content.Read(),"I","UTF8")
      /// creation obj dynamique consommant le body json
      set dyna = {}.%FromJSON(body)
      /// construire le messaage json
      set tFormation = ##class(Formation.Obj.Formation).%New()
      set tFormation.Nom = dyna.nom
      set tFormation.Salle = dyna.salle
      set tMsg.Formation = tFormation

      /// envoi du message vers BS tBsName (recup processus dans la prod)
       $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
      // envoi le message dans la production via la methode ProcessInput du BS RestInputToLocalBDD, tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.ProcessInput(tMsg,.output))

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

/// // import vers Remote
ClassMethod importRemoteObjet() As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToRemoteBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationInsertRequest).%New()
        
        // permet de lire le contenu Message et convertir en utf8
      set body = $zcvt(%request.Content.Read(),"I","UTF8")
      /// creation obj dynamique consommant le body json
      set dyna = {}.%FromJSON(body)
      /// construire le messaage json
      set tFormation = ##class(Formation.Obj.Formation).%New()
      set tFormation.Nom = dyna.nom
      set tFormation.Salle = dyna.salle
      set tMsg.Formation = tFormation

      /// envoi du message vers BS tBsName (recup processus dans la prod)
       $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
      // envoi le message dans la production via la methode ProcessInput du BS RestInputToLocalBDD, tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.ProcessInput(tMsg,.output))

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

// export avec select depuis LocalBDD

ClassMethod exportAllFromLocal() As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToLocalBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationSelectAllRequest).%New()
        
      /// recuperation du processus du BS tBsName dans la prod
       //$$$LOGINFO("Recuperation du processuss du BS dans la production")
       $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
      // envoi le message dans la production via la methode ExportFromLocalBDD du BS RestInputToLocalBDD, tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.ExportAllFromLocalBDD(tMsg,.output))
        // initialise la liste dans laquelle on va stocker les objets jsson
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
        // Conversion et rendement en json
      write dyna.%ToJSON()

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

ClassMethod exportByNameFromLocal(name As %String) As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToLocalBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationSelectByNameRequest).%New()
        set tMsg.Nom = name
      /// recuperation du processus du BS tBsName dans la prod
       //$$$LOGINFO("Recuperation du processuss du BS dans la production")
       $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
      // envoi le message dans la production via la methode ExportFromLocalBDD du BS RestInputToLocalBDD, tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.ExportByNameFromLocalBDD(tMsg,.output))
        // initialise la liste dans laquelle on va stocker les objets jsson
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
        // Conversion et rendement en json
      write dyna.%ToJSON()

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

// export avec select depuis RemoteBDD

ClassMethod exportAllFromRemote() As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToRemoteBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationSelectAllRequest).%New()
        
      /// recuperation du processus du BS tBsName dans la prod
       //$$$LOGINFO("Recuperation du processuss du BS dans la production")
       $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
      // envoi le message dans la production via la methode ExportFromLocalBDD du BS RestInputToLocalBDD, tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.ExportAllFromRemoteBDD(tMsg,.output))
        // initialise la liste dans laquelle on va stocker les objets jsson
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
        // Conversion et rendement en json
      write dyna.%ToJSON()

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

ClassMethod exportLocalImportRemoteByname(name As %String) As %Status
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

ClassMethod exportLocalImportRemoteAll() As %Status
{
  set tSc = $$$OK

  Try {
        // BS destinataire du message
        set tBsName = "RestInputToLocalBDD"
        // Message à inserer
        set tMsg = ##class(Formation.Msg.FormationSelectByNameRequest).%New()
        ///set tMsg.Nom = name
        /// envoi du message vers BS tBsName (recup processus dans la prod)
        $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
        // envoi le message dans le BS RestInputToLocalBDD via la methode FromLocalToremoteBDD (donc dans la production ), tService est l'instance du service dans la prod
        $$$ThrowOnError(tService.AllFromLocalToremoteBDD(tMsg,.output))
         // envoi le message dans le service (donc dans la production), tService est l'instance du service dans la prod
        //$$$ThrowOnError(tService.FromLocalToremoteBDDByLot(tMsg,.output))

  } Catch ex {
      set tSc = ex.AsStatus()
  }

  Quit tSc
}

}
