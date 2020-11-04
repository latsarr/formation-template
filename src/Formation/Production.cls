Class Formation.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Formation.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="LocalBDD" Category="" ClassName="Formation.BO.LocalBDD" PoolSize="1" Enabled="true" Foreground="false" Comment="Quand on modifie une classe BO il recharger l&apos;instance de l&apos;opération pour que le nouvel objet prenne en compte la classe nouvellement modifiée  A faire unitairement sur l opération concernée" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Main" Category="" ClassName="Formation.BP.Main" PoolSize="1" Enabled="true" Foreground="false" Comment="Traitement unitaire pour Insertion sur les 2 dbb local et remote" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="FileService" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="false" Foreground="false" Comment="Acheminement unitaire de la source csv vers le main" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">Formation.RM.CSV</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Main</Setting>
    <Setting Target="Adapter" Name="FilePath">/tmp/iris/misc/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
  </Item>
  <Item Name="Batch" Category="" ClassName="Formation.BP.Batch" PoolSize="1" Enabled="true" Foreground="false" Comment="Traitement en boucle Utilisant le main pour inserer dans les 2 bases locales et remote" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="BatchFileService" Category="" ClassName="EnsLib.RecordMap.Service.BatchFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="Acheminement en lot de la source csv vers le batch" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BatchClass">Formation.RM.CSV.Batch</Setting>
    <Setting Target="Host" Name="BatchHandling">Whole</Setting>
    <Setting Target="Host" Name="RecordMap">Formation.RM.CSV</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Batch</Setting>
    <Setting Target="Adapter" Name="FilePath">/tmp/iris/misc/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
  </Item>
  <Item Name="RemoteBDD" Category="" ClassName="Formation.BO.RemoteBDD" PoolSize="1" Enabled="true" Foreground="false" Comment="base remote via le service JG" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DSN">Postgre</Setting>
    <Setting Target="Adapter" Name="Credentials">DemoData</Setting>
    <Setting Target="Adapter" Name="JDBCClasspath"></Setting>
    <Setting Target="Adapter" Name="JDBCDriver"></Setting>
    <Setting Target="Adapter" Name="StayConnected">10</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="Java Geteway utilisé par l&apos;operation RemoteBDD" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="LocalToRemote" Category="" ClassName="Formation.BP.LocalToRemote" PoolSize="1" Enabled="true" Foreground="false" Comment="Traitement de Recuperation via une requete sql depuis la base locale et d&apos;insertion dans la base remote" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
